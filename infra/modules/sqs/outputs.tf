# Outputs del módulo SQS
# Proporciona los valores necesarios para la conexión desde otros módulos y servicios

output "queue_url" {
  description = "URL de la cola de mensajes principal"
  value       = aws_sqs_queue.orders_queue.url
}

output "queue_arn" {
  description = "ARN de la cola de mensajes principal"
  value       = aws_sqs_queue.orders_queue.arn
}

output "queue_name" {
  description = "Nombre de la cola de mensajes principal"
  value       = aws_sqs_queue.orders_queue.name
}

output "queue_id" {
  description = "ID de la cola de mensajes principal"
  value       = aws_sqs_queue.orders_queue.id
}

output "dlq_url" {
  description = "URL de la cola de mensajes dead letter"
  value       = var.dlq_enabled ? aws_sqs_queue.dlq[0].url : null
}

output "dlq_arn" {
  description = "ARN de la cola de mensajes dead letter"
  value       = var.dlq_enabled ? aws_sqs_queue.dlq[0].arn : null
}

output "dlq_name" {
  description = "Nombre de la cola de mensajes dead letter"
  value       = var.dlq_enabled ? aws_sqs_queue.dlq[0].name : null
}

output "all_queue_urls" {
  description = "Mapa con todas las URLs de colas"
  value = {
    main = aws_sqs_queue.orders_queue.url
    dlq  = var.dlq_enabled ? aws_sqs_queue.dlq[0].url : ""
  }
}

output "all_queue_arns" {
  description = "Mapa con todos los ARNs de colas"
  value = {
    main = aws_sqs_queue.orders_queue.arn
    dlq  = var.dlq_enabled ? aws_sqs_queue.dlq[0].arn : ""
  }
}