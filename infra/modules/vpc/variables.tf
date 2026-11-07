# Variables específicas para el módulo VPC.
# Estas variables permiten configurar la red para el servicio de ordenes,
# incluyendo subredes públicas y privadas, y el bloque CIDR de la VPC.

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El valor proporcionado para vpc_cidr no es un CIDR válido."
  }
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
  validation {
    condition     = length(var.public_subnet_cidrs) >= 2 && alltrue([for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Debe proporcionar al menos dos CIDRs válidos para subredes públicas."
  }
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
  validation {
    condition     = length(var.private_subnet_cidrs) >= 2 && alltrue([for cidr in var.private_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Debe proporcionar al menos dos CIDRs válidos para subredes privadas."
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

variable "enable_nat_gateway" {
  description = "Indica si se debe crear un NAT Gateway para las subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Indica si se debe usar un único NAT Gateway para todas las subredes privadas"
  type        = bool
  default     = true
}