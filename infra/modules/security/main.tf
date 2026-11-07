# Módulo de seguridad para el servicio de órdenes
# Superficie de práctica: completar la configuración de grupos de seguridad y políticas IAM

# Grupo de seguridad para el servicio de órdenes
resource "aws_security_group" "orders_service" {
  name        = var.security_group_name
  description = "Grupo de seguridad para el servicio de órdenes"
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = var.security_group_name
    }
  )
}

# Reglas de entrada - completar según necesidades del servicio
resource "aws_vpc_security_group_ingress_rule" "orders_ingress_http" {
  for_each          = toset(var.allowed_cidr_blocks)
  security_group_id = aws_security_group.orders_service.id
  cidr_ipv4         = each.value
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP traffic"
}

resource "aws_vpc_security_group_ingress_rule" "orders_ingress_https" {
  for_each          = toset(var.allowed_cidr_blocks)
  security_group_id = aws_security_group.orders_service.id
  cidr_ipv4         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS traffic"
}

# Reglas de salida
resource "aws_vpc_security_group_egress_rule" "orders_egress_all" {
  security_group_id = aws_security_group.orders_service.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

# Rol IAM para el servicio de órdenes
resource "aws_iam_role" "orders_service_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

# Política IAM básica - completar con permisos específicos
resource "aws_iam_policy" "orders_service_policy" {
  name        = var.iam_policy_name
  description = "Política IAM para el servicio de órdenes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.sqs_queue_arn
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = var.dynamodb_table_arn
      }
    ]
  })

  tags = var.common_tags
}

# Adjuntar política al rol
resource "aws_iam_role_policy_attachment" "orders_service_attachment" {
  role       = aws_iam_role.orders_service_role.name
  policy_arn = aws_iam_policy.orders_service_policy.arn
}