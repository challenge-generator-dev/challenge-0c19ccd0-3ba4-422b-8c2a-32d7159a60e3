# Variables globales para parametrizar la configuración de la infraestructura del servicio de ordenes.
# Estas variables permiten adaptar la infraestructura a diferentes entornos (dev, prod, etc.)
# sin modificar el código base.

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, prod, etc.)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_username" {
  description = "Nombre de usuario para la base de datos RDS"
  type        = string
  default     = "orderservice"
}

variable "db_password" {
  description = "Contraseña para la base de datos RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Clase de instancia para la base de datos RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Espacio de almacenamiento asignado para la base de datos RDS (en GB)"
  type        = number
  default     = 20
}

variable "sqs_queue_name" {
  description = "Nombre de la cola SQS para el servicio de ordenes"
  type        = string
  default     = "order-events"
}

variable "sqs_delay_seconds" {
  description = "Tiempo de retraso para mensajes en la cola SQS (en segundos)"
  type        = number
  default     = 0
}

variable "sqs_max_message_size" {
  description = "Tamaño máximo de mensaje en la cola SQS (en bytes)"
  type        = number
  default     = 262144
}

variable "sqs_message_retention_seconds" {
  description = "Tiempo de retención de mensajes en la cola SQS (en segundos)"
  type        = number
  default     = 345600
}

variable "security_group_name" {
  description = "Nombre del grupo de seguridad para el servicio de ordenes"
  type        = string
  default     = "order-service-sg"
}