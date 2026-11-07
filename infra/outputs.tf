# Outputs de la infraestructura del servicio de órdenes
# Este archivo expone la información crítica de los recursos aprovisionados

# Output del ID de la VPC principal
output "vpc_id" {
  description = "ID de la VPC donde se despliega el servicio"
  value       = module.vpc.vpc_id
}

# Outputs de las subnets
output "private_subnet_ids" {
  description = "IDs de las subnets privadas donde se ejecutan los servicios"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas para recursos expuestos"
  value       = module.vpc.public_subnet_ids
}

# Outputs de la base de datos RDS
output "rds_endpoint" {
  description = "Endpoint de conexión a la base de datos RDS"
  value       = module.rds.endpoint
  sensitive   = true
}

output "rds_port" {
  description = "Puerto de la base de datos RDS"
  value       = module.rds.port
}

output "rds_arn" {
  description = "ARN de la instancia RDS"
  value       = module.rds.arn
}

output "rds_database_name" {
  description = "Nombre de la base de datos"
  value       = module.rds.database_name
}

# Outputs de la cola SQS
output "orders_queue_url" {
  description = "URL de la cola SQS para procesamiento de órdenes"
  value       = module.sqs.orders_queue_url
}

output "orders_queue_arn" {
  description = "ARN de la cola SQS para procesamiento de órdenes"
  value       = module.sqs.orders_queue_arn
}

output "dead_letter_queue_url" {
  description = "URL de la cola SQS para mensajes fallidos"
  value       = module.sqs.dead_letter_queue_url
}

output "dead_letter_queue_arn" {
  description = "ARN de la cola SQS para mensajes fallidos"
  value       = module.sqs.dead_letter_queue_arn
}

# Outputs de seguridad
output "security_group_id" {
  description = "ID del security group principal"
  value       = module.security.main_security_group_id
}

output "security_group_name" {
  description = "Nombre del security group principal"
  value       = module.security.main_security_group_name
}

output "alb_security_group_id" {
  description = "ID del security group del Application Load Balancer"
  value       = module.security.alb_security_group_id
}

output "rds_security_group_id" {
  description = "ID del security group para RDS"
  value       = module.security.rds_security_group_id
}

output "ecs_security_group_id" {
  description = "ID del security group para los servicios ECS"
  value       = module.security.ecs_security_group_id
}

# Outputs de red adicionales
output "nat_gateway_ips" {
  description = "IPs de los NAT Gateways para salida a internet"
  value       = module.vpc.nat_gateway_ips
}

output "vpc_cidr_block" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}

output "availability_zones" {
  description = "Zonas de disponibilidad utilizadas"
  value       = module.vpc.availability_zones
}

# Output regional
output "region" {
  description = "Región de AWS donde se despliega la infraestructura"
  value       = var.aws_region
}

# Outputs de información general
output "environment" {
  description = "Entorno de despliegue"
  value       = var.environment
}

output "resource_prefix" {
  description = "Prefijo común para todos los recursos"
  value       = var.resource_prefix
}