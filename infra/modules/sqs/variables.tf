# Variables específicas para el módulo SQS.
# Estas variables permiten configurar la cola de mensajes para el servicio de ordenes,
# incluyendo el nombre de la cola, retrasos y tamaño máximo de mensaje.

variable "sqs_queue_name" {
  description = "Nombre de la cola SQS para el servicio de ordenes"
  type        = string
  validation {
    condition     = length(var.sqs_queue_name) >= 3 && length(var.sqs_queue_name) <= 80 && can(regex("^[a-zA-Z0-9_-]*$", var.sqs_queue_name))
    error_message = "El nombre de la cola debe tener entre 3 y 80 caracteres y solo contener letras, números, guiones y guiones bajos."
  }
}

variable "sqs_delay_seconds" {
  description = "Tiempo de retraso para mensajes en la cola SQS (en segundos)"
  type        = number
  default     = 0
  validation {
    condition     = var.sqs_delay_seconds >= 0 && var.sqs_delay_seconds <= 900
    error_message = "El retraso debe estar entre 0 y 900 segundos."
  }
}

variable "sqs_max_message_size" {
  description = "Tamaño máximo de mensaje en la cola SQS (en bytes)"
  type        = number
  default     = 262144
  validation {
    condition     = var.sqs_max_message_size >= 1024 && var.sqs_max_message_size <= 262144
    error_message = "El tamaño máximo de mensaje debe estar entre 1024 y 262144 bytes."
  }
}

variable "sqs_message_retention_seconds" {
  description = "Tiempo de retención de mensajes en la cola SQS (en segundos)"
  type        = number
  default     = 345600
  validation {
    condition     = var.sqs_message_retention_seconds >= 60 && var.sqs_message_retention_seconds <= 1209600
    error_message = "El tiempo de retención debe estar entre 60 segundos (1 minuto) y 1209600 segundos (14 días)."
  }
}

variable "sqs_receive_wait_time_seconds" {
  description = "Tiempo de espera para la recepción de mensajes (en segundos)"
  type        = number
  default     = 0
  validation {
    condition     = var.sqs_receive_wait_time_seconds >= 0 && var.sqs_receive_wait_time_seconds <= 20
    error_message = "El tiempo de espera debe estar entre 0 y 20 segundos."
  }
}

variable "environment" {
  description = "Entorno de despliegue (dev, prod, etc.)"
  type        = string
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "El entorno debe ser uno de: dev, prod, staging."
  }
}

variable "fifo_queue" {
  description = "Indica si la cola SQS debe ser FIFO"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Indica si se debe habilitar la deduplicación basada en contenido para colas FIFO"
  type        = bool
  default     = false
}