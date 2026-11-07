# Configuración principal de Terraform para el servicio de órdenes
# Este archivo orquesta los módulos que aprovisionan la infraestructura

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = "platform-team"
  }
}

# Módulo de VPC - Red virtual privada
module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  project     = var.project
  vpc_cidr    = var.vpc_cidr

  tags = local.common_tags
}

# Módulo de RDS - Base de datos PostgreSQL
module "rds" {
  source = "./modules/rds"

  environment           = var.environment
  project               = var.project
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  db_engine_version     = var.db_engine_version
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  security_group_id     = module.vpc.rds_security_group_id

  tags = local.common_tags
}

# Módulo de SQS - Cola de mensajes
module "sqs" {
  source = "./modules/sqs"

  environment    = var.environment
  project        = var.project
  sqs_queue_name = var.sqs_queue_name
  vpc_id         = module.vpc.vpc_id

  tags = local.common_tags
}

# Módulo de Security - Políticas IAM y seguridad
module "security" {
  source = "./modules/security"

  environment     = var.environment
  project         = var.project
  vpc_id          = module.vpc.vpc_id
  sqs_queue_arn   = module.sqs.sqs_queue_arn
  db_instance_arn = module.rds.db_instance_arn

  tags = local.common_tags
}