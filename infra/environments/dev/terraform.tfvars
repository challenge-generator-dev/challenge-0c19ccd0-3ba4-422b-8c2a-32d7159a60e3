# Variables específicas del entorno de desarrollo
# Estas variables proporcionan valores para los recursos de AWS del servicio de órdenes

# Configuración general del entorno
environment           = "dev"
aws_region            = "us-east-1"

# Configuración de la VPC
vpc_cidr              = "10.0.0.0/16"
public_subnets_cidr   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr  = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Configuración de la base de datos RDS PostgreSQL
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "orders_db"
db_username          = "orders_admin"
# La contraseña se proporciona a través de TF_VAR_db_password en变量 de entorno
db_engine_version    = "16.3"
db_multi_az          = false

# Configuración de SQS para el servicio de órdenes
sqs_queue_name       = "orders-queue-dev"
sqs_max_message_size = 262144
sqs_retention_period = 345600
sqs_visibility_timeout = 30

# Configuración de seguridad
enable_vpc_flow_logs = true
allowed_cidr_blocks  = ["0.0.0.0/0"]

# Tags para identificación y gestión de costos
common_tags = {
  Environment = "dev"
  Project     = "orders-service"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
}