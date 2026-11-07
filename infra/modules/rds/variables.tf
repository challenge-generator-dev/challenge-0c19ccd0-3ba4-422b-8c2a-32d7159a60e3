# Variables específicas para el módulo RDS.
# Estas variables permiten configurar la base de datos relacional para el servicio de ordenes,
# incluyendo credenciales, clase de instancia y almacenamiento.

variable "db_username" {
  description = "Nombre de usuario para la base de datos RDS"
  type        = string
  validation {
    condition     = length(var.db_username) >= 3 && length(var.db_username) <= 16
    error_message = "El nombre de usuario debe tener entre 3 y 16 caracteres."
  }
}

variable "db_password" {
  description = "Contraseña para la base de datos RDS"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_password) >= 8 && length(regexall("[A-Z]", var.db_password)) > 0 && length(regexall("[a-z]", var.db_password)) > 0 && length(regexall("[0-9]", var.db_password)) > 0
    error_message = "La contraseña debe tener al menos 8 caracteres, incluyendo mayúsculas, minúsculas y números."
  }
}

variable "db_instance_class" {
  description = "Clase de instancia para la base de datos RDS"
  type        = string
  default     = "db.t3.micro"
  validation {
    condition     = contains(["db.t3.micro", "db.t3.small", "db.t3.medium", "db.m5.large"], var.db_instance_class)
    error_message = "La clase de instancia debe ser una de: db.t3.micro, db.t3.small, db.t3.medium, db.m5.large."
  }
}

variable "db_allocated_storage" {
  description = "Espacio de almacenamiento asignado para la base de datos RDS (en GB)"
  type        = number
  default     = 20
  validation {
    condition     = var.db_allocated_storage >= 20 && var.db_allocated_storage <= 65536
    error_message = "El almacenamiento asignado debe estar entre 20 GB y 65536 GB."
  }
}

variable "db_engine" {
  description = "Motor de base de datos para RDS"
  type        = string
  default     = "postgres"
  validation {
    condition     = contains(["postgres", "mysql"], var.db_engine)
    error_message = "El motor de base de datos debe ser postgres o mysql."
  }
}

variable "db_engine_version" {
  description = "Versión del motor de base de datos"
  type        = string
  default     = "16.3"
  validation {
    condition     = can(regex("^\\d+\\.\\d+$", var.db_engine_version))
    error_message = "La versión del motor debe estar en formato X.Y (ejemplo: 16.3)."
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

variable "vpc_security_group_ids" {
  description = "Lista de IDs de grupos de seguridad para la base de datos RDS"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas para la base de datos RDS"
  type        = list(string)
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "orderservice"
  validation {
    condition     = length(var.db_name) >= 3 && length(var.db_name) <= 64 && can(regex("^[a-zA-Z][a-zA-Z0-9_]*$", var.db_name))
    error_message = "El nombre de la base de datos debe comenzar con una letra, tener entre 3 y 64 caracteres, y solo contener letras, números y guiones bajos."
  }
}