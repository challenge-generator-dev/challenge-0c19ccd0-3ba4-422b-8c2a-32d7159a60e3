# Módulo RDS - Configuración de base de datos relacional
# Este módulo aprovisiona una instancia de base de datos PostgreSQL

# Subnet group para RDS
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-${var.service_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-db-subnet-group"
    }
  )
}

# Security group para RDS
resource "aws_security_group" "rds" {
  name        = "${var.environment}-${var.service_name}-rds-sg"
  description = "Security group para RDS del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    cidr_blocks     = var.allowed_cidr_blocks
    description     = "Acceso a la base de datos"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida permitida"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-rds-sg"
    }
  )
}

# Parámetros del cluster/base de datos
resource "aws_db_instance" "main" {
  identifier     = "${var.environment}-${var.service_name}-db"
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  # Almacenamiento
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  # Credenciales
  username             = var.db_username
  password             = var.db_password
  manage_master_user_password = var.manage_master_user_password

  # Red
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Configuración
  port                  = var.db_port
  database_name         = var.database_name
  publicly_accessible   = var.publicly_accessible
  skip_final_snapshot   = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  # Backup y mantenimiento
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  copy_tags_to_snapshot   = true

  # Performance
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_interval > 0 ? var.iam_role_for_monitoring : null

  # Lifecycle
  deletion_protection = var.deletion_protection
  multi_az            = var.multi_az

  # Tags
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.service_name}-db"
    }
  )

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

# Rol IAM para Enhanced Monitoring (si está habilitado)
resource "aws_iam_role" "rds_monitoring_role" {
  count = var.monitoring_interval > 0 ? 1 : 0

  name = "${var.environment}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  count = var.monitoring_interval > 0 ? 1 : 0

  role       = aws_iam_role.rds_monitoring_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}