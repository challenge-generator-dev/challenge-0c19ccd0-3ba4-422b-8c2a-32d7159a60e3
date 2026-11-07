# Outputs del módulo RDS
# Proporciona los valores necesarios para la conexión desde otros módulos

output "db_instance_address" {
  description = "Dirección del endpoint de la instancia de base de datos"
  value       = aws_db_instance.main.address
}

output "db_instance_arn" {
  description = "ARN de la instancia de base de datos"
  value       = aws_db_instance.main.arn
}

output "db_instance_id" {
  description = "Identificador de la instancia de base de datos"
  value       = aws_db_instance.main.id
}

output "db_instance_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.main.db_name
}

output "db_instance_port" {
  description = "Puerto de la base de datos"
  value       = aws_db_instance.main.port
}

output "db_instance_endpoint" {
  description = "Endpoint completo de la instancia de base de datos"
  value       = aws_db_instance.main.endpoint
}

output "db_subnet_group_name" {
  description = "Nombre del grupo de subnets de la base de datos"
  value       = aws_db_subnet_group.main.name
}

output "db_security_group_id" {
  description = "ID del security group asociado a la base de datos"
  value       = aws_security_group.rds.id
}

output "db_security_group_arn" {
  description = "ARN del security group asociado a la base de datos"
  value       = aws_security_group.rds.arn
}