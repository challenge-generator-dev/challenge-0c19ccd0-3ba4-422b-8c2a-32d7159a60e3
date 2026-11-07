# Outputs del módulo de seguridad

output "security_group_id" {
  description = "ID del grupo de seguridad del servicio de órdenes"
  value       = aws_security_group.orders_service.id
}

output "security_group_arn" {
  description = "ARN del grupo de seguridad del servicio de órdenes"
  value       = aws_security_group.orders_service.arn
}

output "iam_role_name" {
  description = "Nombre del rol IAM del servicio de órdenes"
  value       = aws_iam_role.orders_service_role.name
}

output "iam_role_arn" {
  description = "ARN del rol IAM del servicio de órdenes"
  value       = aws_iam_role.orders_service_role.arn
}

output "iam_policy_arn" {
  description = "ARN de la política IAM del servicio de órdenes"
  value       = aws_iam_policy.orders_service_policy.arn
}