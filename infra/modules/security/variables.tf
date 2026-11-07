# Variables específicas para el módulo de seguridad.
# Estas variables permiten configurar los grupos de seguridad y políticas IAM
# para el servicio de ordenes, asegurando el principio de least privilege.

variable "security_group_name" {
  description = "Nombre del grupo de seguridad para el servicio de ordenes"
  type        = string
  validation {
    condition     = length(var.security_group_name) >= 3 && length(var.security_group_name) <= 255 && can(regex("^[a-zA-Z0-9_-]*$", var.security_group_name))
    error_message = "El nombre del grupo de seguridad debe tener entre 3 y 255 caracteres y solo contener letras, números, guiones y guiones bajos."
  }
}

variable "vpc_id" {
  description = "ID de la VPC donde se crearán los grupos de seguridad"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, prod, etc.)"
  type        = string
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "El entorno debe ser uno de: dev, prod, staging."
  }
}

variable "ingress_rules" {
  description = "Lista de reglas de ingreso para el grupo de seguridad"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP access from anywhere"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS access from anywhere"
    }
  ]
  validation {
    condition     = alltrue([for rule in var.ingress_rules : contains(["tcp", "udp", "icmp"], rule.protocol)])
    error_message = "El protocolo debe ser tcp, udp o icmp."
  }
}

variable "egress_rules" {
  description = "Lista de reglas de egreso para el grupo de seguridad"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
  validation {
    condition     = alltrue([for rule in var.egress_rules : contains(["tcp", "udp", "icmp", "-1"], rule.protocol)])
    error_message = "El protocolo debe ser tcp, udp, icmp o -1 (todos)."
  }
}

variable "iam_policy_name" {
  description = "Nombre de la política IAM para el servicio de ordenes"
  type        = string
  default     = "order-service-policy"
  validation {
    condition     = length(var.iam_policy_name) >= 3 && length(var.iam_policy_name) <= 128 && can(regex("^[a-zA-Z0-9_-]*$", var.iam_policy_name))
    error_message = "El nombre de la política IAM debe tener entre 3 y 128 caracteres y solo contener letras, números, guiones y guiones bajos."
  }
}

variable "iam_role_name" {
  description = "Nombre del rol IAM para el servicio de ordenes"
  type        = string
  default     = "order-service-role"
  validation {
    condition     = length(var.iam_role_name) >= 3 && length(var.iam_role_name) <= 64 && can(regex("^[a-zA-Z0-9_-]+$", var.iam_role_name))
    error_message = "El nombre del rol IAM debe tener entre 3 y 64 caracteres y solo contener letras, números, guiones y guiones bajos."
  }
}

variable "iam_policy_actions" {
  description = "Lista de acciones permitidas en la política IAM para el servicio de ordenes"
  type        = list(string)
  default = [
    "sqs:SendMessage",
    "sqs:ReceiveMessage",
    "sqs:DeleteMessage",
    "sqs:GetQueueAttributes",
    "rds:DescribeDBInstances",
    "rds:Connect"
  ]
  validation {
    condition     = alltrue([for action in var.iam_policy_actions : can(regex("^[a-zA-Z0-9:]*$", action))])
    error_message = "Cada acción de la política IAM debe ser una cadena válida (ejemplo: sqs:SendMessage)."
  }
}

variable "iam_policy_resources" {
  description = "Lista de recursos ARN a los que se aplica la política IAM"
  type        = list(string)
  default     = ["*"]
  validation {
    condition     = alltrue([for resource in var.iam_policy_resources : can(regex("^arn:aws:[a-zA-Z0-9-]+:[a-zA-Z0-9-]*:[0-9]*:[a-zA-Z0-9-/:_]*$", resource)) || resource == "*"])
    error_message = "Cada recurso de la política IAM debe ser un ARN válido o *."
  }
}