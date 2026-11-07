# Outputs del módulo VPC
# Expose información crítica de la red para otros módulos

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = aws_subnet.private[*].id
}

output "availability_zones" {
  description = "Zonas de disponibilidad configuradas"
  value       = var.availability_zones
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "ID de la route table pública"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs de las route tables privadas"
  value       = aws_route_table.private[*].id
}