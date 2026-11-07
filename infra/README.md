# Infraestructura Terraform para el Servicio de Órdenes

Este módulo aprovisiona la infraestructura necesaria en AWS para el servicio de órdenes.

## Estructura del Módulo

```
infra/
├── main.tf          # Configuración principal y composición de módulos
├── versions.tf      # Definición de versiones de Terraform y providers
├── variables.tf     # Variables del módulo raíz (definido en otro lote)
├── outputs.tf       # Outputs del módulo raíz (definido en otro lote)
├── providers.tf     # Configuración de providers (definido en otro lote)
└── modules/         # Módulos reutilizables
    ├── vpc/         # Configuración de red virtual
    ├── rds/         # Base de datos PostgreSQL
    ├── sqs/         # Cola de mensajes para procesamiento asíncrono
    └── security/    # Políticas IAM y seguridad
```

## Recursos Aprovisionados

### VPC (Red Virtual)
- VPC con CIDR block configurable
- Subnets públicas y privadas en múltiples AZs
- Internet Gateway y NAT Gateways
- Tablas de enrutamiento
- Security Groups para los servicios

### RDS (Base de Datos)
- Instancia PostgreSQL con Multi-AZ opcional
- Parameter Groups y Option Groups configurables
- Backups automatizados con retención configurable
- Read Replicas para escalamiento de lectura
- Secrets en AWS Secrets Manager para credenciales

### SQS (Cola de Mensajes)
- Cola principal para procesamiento de órdenes
- Colas dead-letter para mensajes fallidos
- Configuración de políticas de retención y visibilidad
- DLQ (Dead Letter Queue) configurada

### Security (Seguridad)
- Roles IAM con permisos mínimos necesarios
- Políticas de acceso a recursos AWS
- Encryption at rest para todos los recursos
- Logging y monitoreo configurado

## Uso Básico

```hcl
module "infra" {
  source = "./infra"

  environment = "prod"
  project     = "orders-service"
  region      = "us-east-1"

  vpc_cidr = "10.0.0.0/16"

  db_instance_class    = "db.t3.medium"
  db_allocated_storage = 100

  sqs_queue_name = "orders-queue"
}
```

## Validación Local

Para validar la configuración de Terraform localmente:

```bash
cd infra
terraform init
terraform validate
terraform plan
```

Para aplicar los cambios:

```bash
terraform apply
```

## Entornos

La infraestructura soporta múltiples entornos:

- **dev**: Entorno de desarrollo con recursos pequeños
- **prod**: Entorno de producción con alta disponibilidad

Cada entorno tiene su propia configuración en `environments/`.

## Consideraciones de Seguridad

- Todos los recursos tienen tags para identificación y costos
- Las bases de datos tienen encryption at rest habilitada
- Los buckets de S3 tienen versioning habilitado
- Los secretos se almacenan en AWS Secrets Manager
- Las políticas IAM siguen el principio de mínimo privilegio
- El acceso a la VPC es privado mediante subnets privadas

## Outputs Principales

- `vpc_id`: ID de la VPC creada
- `db_endpoint`: Endpoint de la base de datos RDS
- `db_name`: Nombre de la base de datos
- `sqs_queue_url`: URL de la cola SQS principal
- `sqs_dlq_url`: URL de la cola dead-letter
- `iam_role_arn`: ARN del rol IAM para el servicio

## Tags Consistentes

Todos los recursos incluyen los siguientes tags:

- `Project`: Nombre del proyecto
- `Environment`: Entorno (dev/prod)
- `ManagedBy`: "terraform"
- `Owner`: Equipo responsable