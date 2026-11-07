# Configuración principal del módulo SQS
# Define las colas de mensajes para el servicio de órdenes

resource "aws_sqs_queue" "orders_queue" {
  name                        = var.queue_name
  message_retention_seconds   = var.message_retention_seconds
  visibility_timeout_seconds  = var.visibility_timeout
  max_message_size            = var.max_message_size
  delay_seconds               = var.delay_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  dead_letter_target_arn      = var.dlq_enabled ? aws_sqs_queue.dlq[0].arn : null
  max_receive_count           = var.max_receive_count
  tags                        = var.tags

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_sqs_queue" "dlq" {
  count = var.dlq_enabled ? 1 : 0

  name                        = "${var.queue_name}-dlq"
  message_retention_seconds   = var.dlq_message_retention
  max_message_size            = var.max_message_size
  tags                        = var.tags
}

resource "aws_sqs_queue_policy" "orders_queue_policy" {
  queue_url = aws_sqs_queue.orders_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "sqs-policy"
    Statement = [
      {
        Sid       = "AllowSQSMessages"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["sqs:SendMessage", "sqs:ReceiveMessage"]
        Resource  = aws_sqs_queue.orders_queue.arn
        Condition = {
          Bool = {
            "aws:SecureTransport" = "true"
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_redrive_policy" "orders_queue_redrive" {
  queue_url          = aws_sqs_queue.orders_queue.id
  redrive_policy     = jsonencode({
    deadLetterTargetArn = var.dlq_enabled ? aws_sqs_queue.dlq[0].arn : ""
    maxReceiveCount    = var.max_receive_count
  })
}