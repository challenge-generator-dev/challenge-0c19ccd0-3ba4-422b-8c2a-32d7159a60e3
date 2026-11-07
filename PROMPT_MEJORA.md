# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/rds/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/rds/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/rds/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/sqs/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/sqs/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/sqs/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/security/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/security/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/security/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd api && mvn clean compile` — componente `api` (chapter, support).

### Contratos entre componentes

- `api` expone http (api: http://localhost:8080):
  - `POST /api/orders`
  - `GET /api/orders/{id}`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).
- **Java**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `api/src/main/java/com/orderservice/infrastructure/aws/SQSOrderEventPublisher.java` — `org.slf4j`: El import org.slf4j.Logger pertenece a org.slf4j, pero ninguna dependencia declarada en el pom.xml cubre ese paquete. Falta agregar la dependencia o el import esta mal (libreria equivocada).
- `api/src/main/java/com/orderservice/infrastructure/web/OrderController.java` — `org.slf4j`: El import org.slf4j.Logger pertenece a org.slf4j, pero ninguna dependencia declarada en el pom.xml cubre ese paquete. Falta agregar la dependencia o el import esta mal (libreria equivocada).
- `api/src/main/java/com/orderservice/infrastructure/persistence/JpaOrderRepository.java` — `OrderEntity.toDomain`: Se invoca `toDomain` sobre `OrderEntity`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/infrastructure/persistence/OrderEntity.java` — `OrderItemEntity.setOrder`: Se invoca `setOrder` sobre `OrderItemEntity`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/infrastructure/persistence/OrderItemEntity.java` — `OrderItem.getProductId`: Se invoca `getProductId` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/infrastructure/persistence/OrderItemEntity.java` — `OrderItem.getProductName`: Se invoca `getProductName` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/infrastructure/persistence/OrderItemEntity.java` — `OrderItem.getQuantity`: Se invoca `getQuantity` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/infrastructure/persistence/OrderItemEntity.java` — `OrderItem.getUnitPrice`: Se invoca `getUnitPrice` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/application/OrderService.java` — `SQSOrderEventPublisher.publishOrderStatusChangedEvent`: Se invoca `publishOrderStatusChangedEvent` sobre `SQSOrderEventPublisher`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/infrastructure/web/OrderController.java` — `OrderRequestDTO.customerId`: Se invoca `customerId` sobre `OrderRequestDTO`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orderservice/infrastructure/web/OrderController.java` — `OrderRequestDTO.items`: Se invoca `items` sobre `OrderRequestDTO`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform (corrida e2e 20261106212220607), Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: Infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Aprovisionamiento de infraestructura con Terraform para el servicio de ordenes
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform y definir los recursos básicos necesarios para el servicio de ordenes. — entregable (NO resolver): Configuración de Terraform que define los recursos básicos para el servicio de ordenes.
- Fase 2: Aprovisionamiento de servicios adicionales — objetivo: Aprovisionar servicios adicionales (como bases de datos, servicios de mensajería) necesarios para el funcionamiento del servicio de ordenes. — entregable (NO resolver): Configuración de Terraform que aprovisiona servicios adicionales para el servicio de ordenes.
- Fase 3: Versionado y gestión de la infraestructura — objetivo: Versionar y gestionar la infraestructura aprovisionada utilizando Terraform. — entregable (NO resolver): Configuración versionada de Terraform y pipeline de CI/CD para el despliegue de la infraestructura.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
terraform {
  required_version = "1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "order-service"
      ManagedBy   = "Terraform"
    }
  }
}

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/modules/vpc/variables.tf ===
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

// === ARCHIVO: infra/modules/rds/variables.tf ===
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

// === ARCHIVO: infra/modules/sqs/variables.tf ===
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

// === ARCHIVO: infra/modules/security/variables.tf ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

// === ARCHIVO: infra/README.md ===
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

// === ARCHIVO: infra/main.tf ===
# Configuración principal de Terraform para el servicio de órdenes
# Este archivo orquesta los módulos que aprovisionan la infraestructura

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = "platform-team"
  }
}

# Módulo de VPC - Red virtual privada
module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  project     = var.project
  vpc_cidr    = var.vpc_cidr

  tags = local.common_tags
}

# Módulo de RDS - Base de datos PostgreSQL
module "rds" {
  source = "./modules/rds"

  environment           = var.environment
  project               = var.project
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  db_engine_version     = var.db_engine_version
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  security_group_id     = module.vpc.rds_security_group_id

  tags = local.common_tags
}

# Módulo de SQS - Cola de mensajes
module "sqs" {
  source = "./modules/sqs"

  environment    = var.environment
  project        = var.project
  sqs_queue_name = var.sqs_queue_name
  vpc_id         = module.vpc.vpc_id

  tags = local.common_tags
}

# Módulo de Security - Políticas IAM y seguridad
module "security" {
  source = "./modules/security"

  environment     = var.environment
  project         = var.project
  vpc_id          = module.vpc.vpc_id
  sqs_queue_arn   = module.sqs.sqs_queue_arn
  db_instance_arn = module.rds.db_instance_arn

  tags = local.common_tags
}

// === ARCHIVO: infra/outputs.tf ===
# Outputs de la infraestructura del servicio de órdenes
# Este archivo expone la información crítica de los recursos aprovisionados

# Output del ID de la VPC principal
output "vpc_id" {
  description = "ID de la VPC donde se despliega el servicio"
  value       = module.vpc.vpc_id
}

# Outputs de las subnets
output "private_subnet_ids" {
  description = "IDs de las subnets privadas donde se ejecutan los servicios"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas para recursos expuestos"
  value       = module.vpc.public_subnet_ids
}

# Outputs de la base de datos RDS
output "rds_endpoint" {
  description = "Endpoint de conexión a la base de datos RDS"
  value       = module.rds.endpoint
  sensitive   = true
}

output "rds_port" {
  description = "Puerto de la base de datos RDS"
  value       = module.rds.port
}

output "rds_arn" {
  description = "ARN de la instancia RDS"
  value       = module.rds.arn
}

output "rds_database_name" {
  description = "Nombre de la base de datos"
  value       = module.rds.database_name
}

# Outputs de la cola SQS
output "orders_queue_url" {
  description = "URL de la cola SQS para procesamiento de órdenes"
  value       = module.sqs.orders_queue_url
}

output "orders_queue_arn" {
  description = "ARN de la cola SQS para procesamiento de órdenes"
  value       = module.sqs.orders_queue_arn
}

output "dead_letter_queue_url" {
  description = "URL de la cola SQS para mensajes fallidos"
  value       = module.sqs.dead_letter_queue_url
}

output "dead_letter_queue_arn" {
  description = "ARN de la cola SQS para mensajes fallidos"
  value       = module.sqs.dead_letter_queue_arn
}

# Outputs de seguridad
output "security_group_id" {
  description = "ID del security group principal"
  value       = module.security.main_security_group_id
}

output "security_group_name" {
  description = "Nombre del security group principal"
  value       = module.security.main_security_group_name
}

output "alb_security_group_id" {
  description = "ID del security group del Application Load Balancer"
  value       = module.security.alb_security_group_id
}

output "rds_security_group_id" {
  description = "ID del security group para RDS"
  value       = module.security.rds_security_group_id
}

output "ecs_security_group_id" {
  description = "ID del security group para los servicios ECS"
  value       = module.security.ecs_security_group_id
}

# Outputs de red adicionales
output "nat_gateway_ips" {
  description = "IPs de los NAT Gateways para salida a internet"
  value       = module.vpc.nat_gateway_ips
}

output "vpc_cidr_block" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}

output "availability_zones" {
  description = "Zonas de disponibilidad utilizadas"
  value       = module.vpc.availability_zones
}

# Output regional
output "region" {
  description = "Región de AWS donde se despliega la infraestructura"
  value       = var.aws_region
}

# Outputs de información general
output "environment" {
  description = "Entorno de despliegue"
  value       = var.environment
}

output "resource_prefix" {
  description = "Prefijo común para todos los recursos"
  value       = var.resource_prefix
}

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Variables específicas del entorno de desarrollo
# Estas variables proporcionan valores para los recursos de AWS del servicio de órdenes

# Configuración general del entorno
environment           = "dev"
aws_region            = "us-east-1"

# Configuración de la VPC
vpc_cidr              = "10.0.0.0/16"
public_subnets_cidr   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr  = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Configuración de la base de datos RDS PostgreSQL
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "orders_db"
db_username          = "orders_admin"
# La contraseña se proporciona a través de TF_VAR_db_password en变量 de entorno
db_engine_version    = "16.3"
db_multi_az          = false

# Configuración de SQS para el servicio de órdenes
sqs_queue_name       = "orders-queue-dev"
sqs_max_message_size = 262144
sqs_retention_period = 345600
sqs_visibility_timeout = 30

# Configuración de seguridad
enable_vpc_flow_logs = true
allowed_cidr_blocks  = ["0.0.0.0/0"]

# Tags para identificación y gestión de costos
common_tags = {
  Environment = "dev"
  Project     = "orders-service"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
}

// === ARCHIVO: infra/environments/dev/main.tf ===
# Configuración específica del entorno de desarrollo
# Servicio de Órdenes - AWS Infrastructure

# STUB: Superficie de práctica
# Este archivo debe ser completado por el participante

terraform {
  required_version = ">= 1.9.0"
}

// === ARCHIVO: infra/environments/prod/main.tf ===
# Configuración específica del entorno de producción
# Servicio de Órdenes - AWS Infrastructure

# STUB: Superficie de práctica
# Este archivo debe ser completado por el participante

terraform {
  required_version = ">= 1.9.0"
}

// === ARCHIVO: infra/modules/vpc/main.tf ===
# Módulo VPC - Configuración de red para el servicio de órdenes
# Este módulo define la red virtual privada en AWS

# VPC principal
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-vpc-${var.service_name}"
    }
  )
}

# Subnets públicas
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-public-subnet-${count.index + 1}"
      Type = "public"
    }
  )
}

# Subnets privadas
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-private-subnet-${count.index + 1}"
      Type = "private"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-igw"
    }
  )
}

# Elastic IP para NAT Gateway
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-eip-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# NAT Gateways
resource "aws_nat_gateway" "main" {
  count         = var.enable_nat_gateway ? length(var.availability_zones) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-nat-gw-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# Route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-public-rt"
    }
  )
}

resource "aws_route_table" "private" {
  count  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-private-rt-${count.index + 1}"
    }
  )
}

# Asociación de subnets públicas a route table pública
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Asociación de subnets privadas a route tables privadas
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index % length(aws_route_table.private)].id
}

// === ARCHIVO: infra/modules/vpc/outputs.tf ===
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

// === ARCHIVO: infra/modules/rds/main.tf ===
# Módulo RDS - Configuración de base de datos relacional
# Este módulo aprovisiona una instancia de base de datos PostgreSQL

# Subnet group para RDS
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-${var.service_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-db-subnet-group"
    }
  )
}

# Security group para RDS
resource "aws_security_group" "rds" {
  name        = "${var.environment}-${var.service_name}-rds-sg"
  description = "Security group para RDS del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    cidr_blocks     = var.allowed_cidr_blocks
    description     = "Acceso a la base de datos"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida permitida"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-rds-sg"
    }
  )
}

# Parámetros del cluster/base de datos
resource "aws_db_instance" "main" {
  identifier     = "${var.environment}-${var.service_name}-db"
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  # Almacenamiento
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  # Credenciales
  username             = var.db_username
  password             = var.db_password
  manage_master_user_password = var.manage_master_user_password

  # Red
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Configuración
  port                  = var.db_port
  database_name         = var.database_name
  publicly_accessible   = var.publicly_accessible
  skip_final_snapshot   = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  # Backup y mantenimiento
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  copy_tags_to_snapshot   = true

  # Performance
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_interval > 0 ? var.iam_role_for_monitoring : null

  # Lifecycle
  deletion_protection = var.deletion_protection
  multi_az            = var.multi_az

  # Tags
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.service_name}-db"
    }
  )

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

# Rol IAM para Enhanced Monitoring (si está habilitado)
resource "aws_iam_role" "rds_monitoring_role" {
  count = var.monitoring_interval > 0 ? 1 : 0

  name = "${var.environment}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  count = var.monitoring_interval > 0 ? 1 : 0

  role       = aws_iam_role.rds_monitoring_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

// === ARCHIVO: infra/modules/rds/outputs.tf ===
# Outputs del módulo RDS
# Proporciona los valores necesarios para la conexión desde otros módulos

output "db_instance_address" {
  description = "Dirección del endpoint de la instancia de base de datos"
  value       = aws_db_instance.main.address
}

output "db_instance_arn" {
  description = "ARN de la instancia de base de datos"
  value       = aws_db_instance.main.arn
}

output "db_instance_id" {
  description = "Identificador de la instancia de base de datos"
  value       = aws_db_instance.main.id
}

output "db_instance_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.main.db_name
}

output "db_instance_port" {
  description = "Puerto de la base de datos"
  value       = aws_db_instance.main.port
}

output "db_instance_endpoint" {
  description = "Endpoint completo de la instancia de base de datos"
  value       = aws_db_instance.main.endpoint
}

output "db_subnet_group_name" {
  description = "Nombre del grupo de subnets de la base de datos"
  value       = aws_db_subnet_group.main.name
}

output "db_security_group_id" {
  description = "ID del security group asociado a la base de datos"
  value       = aws_security_group.rds.id
}

output "db_security_group_arn" {
  description = "ARN del security group asociado a la base de datos"
  value       = aws_security_group.rds.arn
}

// === ARCHIVO: infra/modules/sqs/main.tf ===
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

// === ARCHIVO: infra/modules/sqs/outputs.tf ===
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

// === ARCHIVO: infra/modules/security/main.tf ===
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

// === ARCHIVO: infra/modules/security/outputs.tf ===
# Outputs del módulo de seguridad

output "security_group_id" {
  description = "ID del grupo de seguridad del servicio de órdenes"
  value       = aws_security_group.orders_service.id
}

output "security_group_arn" {
  description = "ARN del grupo de seguridad del servicio de órdenes"
  value       = aws_security_group.orders_service.arn
}

output "iam_role_name" {
  description = "Nombre del rol IAM del servicio de órdenes"
  value       = aws_iam_role.orders_service_role.name
}

output "iam_role_arn" {
  description = "ARN del rol IAM del servicio de órdenes"
  value       = aws_iam_role.orders_service_role.arn
}

output "iam_policy_arn" {
  description = "ARN de la política IAM del servicio de órdenes"
  value       = aws_iam_policy.orders_service_policy.arn
}

// === ARCHIVO: infra/.github/workflows/terraform.yml ===
name: Terraform Infrastructure CI/CD

on:
  push:
    branches:
      - main
    paths:
      - '**.tf'
      - '.github/workflows/terraform.yml'
      - 'terraform.tfvars'
  pull_request:
    paths:
      - '**.tf'
      - '.github/workflows/terraform.yml'
      - 'terraform.tfvars'

env:
  TF_VERSION: "1.9.0"
  AWS_REGION: "us-east-1"
  TF_WORKSPACE: "orders-service"

jobs:
  terraform:
    name: Terraform Pipeline
    runs-on: ubuntu-latest
    environment: production
    permissions:
      id-token: write
      contents: read
      pull-requests: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-region: ${{ env.AWS_REGION }}
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          role-session-name: terraform-${{ github.run_id }}

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ env.TF_VERSION }}
          cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}

      - name: Format check
        id: fmt
        run: terraform fmt -check -recursive
        continue-on-error: true

      - name: Terraform Init
        id: init
        run: |
          terraform init \
            -backend-config="bucket=${{ secrets.TF_STATE_BUCKET }}" \
            -backend-config="key=orders-service/terraform.tfstate" \
            -backend-config="region=${{ env.AWS_REGION }}" \
            -backend-config="encrypt=true"

      - name: Terraform Validate
        id: validate
        run: terraform validate

      - name: Terraform Plan
        id: plan
        if: github.event_name == 'pull_request'
        run: |
          terraform plan -no-color \
            -var-file=environments/${{ github.event.inputs.environment || 'dev' }}/terraform.tfvars \
            -out=tfplan
        continue-on-error: true

      - name: Update Pull Request
        if: github.event_name == 'pull_request' && steps.plan.outcome == 'success'
        uses: actions/github-script@v7
        with:
          script: |
            const output = `#### Terraform Plan 📖

            <details><summary>Show Plan</summary>

            \`\`\`terraform
            ${{ steps.plan.outputs.stdout }}
            \`\`\`

            </details>

            *Pushed by: @${{ github.actor }}, Action: \`${{ github.event_name }}\`*`;
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: output
            })

      - name: Plan Status Check
        if: github.event_name == 'pull_request'
        run: |
          if [ "${{ steps.plan.outcome }}" = "failure" ]; then
            exit 1
          fi

      - name: Terraform Apply
        id: apply
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: |
          terraform apply \
            -auto-approve \
            -var-file=environments/prod/terraform.tfvars
        continue-on-error: true

      - name: Apply Status Notification
        if: github.ref == 'refs/heads/main' && github.event_name == 'push' && steps.apply.outcome == 'failure'
        run: |
          echo "::warning::Terraform apply failed. Please check the logs."
          exit 1

      - name: Terraform Output
        if: github.ref == 'refs/heads/main' && github.event_name == 'push' && steps.apply.outcome == 'success'
        run: |
          echo "=== Infrastructure Outputs ===" 
          terraform output

      - name: Post Apply Status
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: |
          echo "Infrastructure deployment completed successfully"
          echo "Timestamp: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
          echo "Commit: ${{ github.sha }}"
          echo "Author: ${{ github.actor }}"

  security-scan:
    name: Security Scan
    runs-on: ubuntu-latest
    needs: terraform
    if: github.event_name == 'pull_request'

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run tfsec
        uses: aquasecurity/tfsec-action@v1.0.0
        with:
          soft_fail: true

      - name: Checkov Scan
        uses: bridgecrewio/checkov-action@master
        with:
          directory: .
          framework: terraform
          soft_fail: true

  drift-detection:
    name: Drift Detection
    runs-on: ubuntu-latest
    needs: terraform
    if: github.event_name == 'schedule'
    schedule:
      - cron: '0 6 * * *'

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-region: ${{ env.AWS_REGION }}
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          role-session-name: terraform-drift-${{ github.run_id }}

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ env.TF_VERSION }}

      - name: Terraform Init
        run: |
          terraform init \
            -backend-config="bucket=${{ secrets.TF_STATE_BUCKET }}" \
            -backend-config="key=orders-service/terraform.tfstate" \
            -backend-config="region=${{ env.AWS_REGION }}"

      - name: Terraform Plan for Drift
        run: |
          terraform plan -no-color -detailed-exitcode -var-file=environments/prod/terraform.tfvars > plan.txt
          PLAN_EXIT_CODE=$?
          if [ $PLAN_EXIT_CODE -eq 2 ]; then
            echo "::warning::Drift detected! Infrastructure has changed outside of Terraform."
            cat plan.txt
            exit 1
          fi
          echo "No drift detected"

// === ARCHIVO: api/pom.xml ===
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.5.6</version>
        <relativePath/>
    </parent>

    <groupId>com.orderservice</groupId>
    <artifactId>order-service</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>order-service</name>
    <description>Order Service for managing orders</description>

    <properties>
        <java.version>21</java.version>
        <spring-cloud.version>2023.0.3</spring-cloud.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>sqs</artifactId>
            <version>2.25.25</version>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>

// === ARCHIVO: api/src/main/java/com/orderservice/Application.java ===
package com.orderservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.web.client.RestTemplate;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.sqs.SqsAsyncClient;

import java.net.URI;

@SpringBootApplication
@EnableAsync
@EnableConfigurationProperties
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    @Bean
    public SqsAsyncClient sqsAsyncClient() {
        return SqsAsyncClient.builder()
                .region(Region.of(System.getenv("AWS_REGION")))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(
                                System.getenv("AWS_ACCESS_KEY_ID"),
                                System.getenv("AWS_SECRET_ACCESS_KEY")
                        )
                ))
                .endpointOverride(URI.create(System.getenv("AWS_SQS_ENDPOINT")))
                .build();
    }
}

// === ARCHIVO: api/src/main/resources/application.yml ===
spring:
  application:
    name: order-service
  datasource:
    url: jdbc:postgresql://${DB_HOST:localhost}:${DB_PORT:5432}/${DB_NAME:orderdb}
    username: ${DB_USERNAME:postgres}
    password: ${DB_PASSWORD:postgres}
    driver-class-name: org.postgresql.Driver
  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: true
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
  flyway:
    enabled: true
    locations: classpath:db/migration
    baseline-on-migrate: true

server:
  port: 8080

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: always

aws:
  region: ${AWS_REGION:us-east-1}
  sqs:
    order-queue-url: ${AWS_SQS_ORDER_QUEUE_URL:http://localhost:4566/000000000000/order-events.fifo}

// === ARCHIVO: api/src/main/java/com/orderservice/domain/Order.java ===
package com.orderservice.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class Order {
    private UUID id;
    private String customerId;
    private List<OrderItem> items;
    private OrderStatus status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private BigDecimal totalAmount;

    public Order(UUID id, String customerId, List<OrderItem> items, OrderStatus status) {
        this.id = id;
        this.customerId = customerId;
        this.items = items;
        this.status = status;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.totalAmount = calculateTotalAmount();
    }

    public UUID getId() {
        return id;
    }

    public String getCustomerId() {
        return customerId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
        this.updatedAt = LocalDateTime.now();
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    private BigDecimal calculateTotalAmount() {
        return items.stream()
                .map(item -> item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static class OrderItem {
        private String productId;
        private String productName;
        private int quantity;
        private BigDecimal unitPrice;

        public OrderItem(String productId, String productName, int quantity, BigDecimal unitPrice) {
            this.productId = productId;
            this.productName = productName;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
        }

        public String getProductId() {
            return productId;
        }

        public String getProductName() {
            return productName;
        }

        public int getQuantity() {
            return quantity;
        }

        public BigDecimal getUnitPrice() {
            return unitPrice;
        }
    }

    public enum OrderStatus {
        CREATED,
        PROCESSING,
        SHIPPED,
        DELIVERED,
        CANCELLED
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/domain/OrderRepository.java ===
package com.orderservice.domain;

import java.util.Optional;
import java.util.UUID;

public interface OrderRepository {
    Order save(Order order);
    Optional<Order> findById(UUID id);
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/persistence/JpaOrderRepository.java ===
package com.orderservice.infrastructure.persistence;

import com.orderservice.domain.Order;
import com.orderservice.domain.OrderRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public class JpaOrderRepository implements OrderRepository {
    private final SpringDataOrderRepository springDataOrderRepository;

    public JpaOrderRepository(SpringDataOrderRepository springDataOrderRepository) {
        this.springDataOrderRepository = springDataOrderRepository;
    }

    @Override
    public Order save(Order order) {
        OrderEntity entity = OrderEntity.fromDomain(order);
        OrderEntity savedEntity = springDataOrderRepository.save(entity);
        return savedEntity.toDomain();
    }

    @Override
    public Optional<Order> findById(UUID id) {
        return springDataOrderRepository.findById(id).map(OrderEntity::toDomain);
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/persistence/OrderEntity.java ===
package com.orderservice.infrastructure.persistence;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "orders")
public class OrderEntity {

    @Id
    private UUID id;

    @Column(name = "customer_id", nullable = false)
    private String customerId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "total_amount", nullable = false, precision = 19, scale = 2)
    private BigDecimal totalAmount;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<OrderItemEntity> items = new ArrayList<>();

    public OrderEntity() {
    }

    public OrderEntity(UUID id, String customerId, String status, BigDecimal totalAmount) {
        this.id = id;
        this.customerId = customerId;
        this.status = status;
        this.totalAmount = totalAmount;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        if (updatedAt == null) {
            updatedAt = LocalDateTime.now();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<OrderItemEntity> getItems() {
        return items;
    }

    public void setItems(List<OrderItemEntity> items) {
        this.items = items;
    }

    public void addItem(OrderItemEntity item) {
        items.add(item);
        item.setOrder(this);
    }

    public void removeItem(OrderItemEntity item) {
        items.remove(item);
        item.setOrder(null);
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/persistence/OrderItemEntity.java ===
package com.orderservice.infrastructure.persistence;


import com.orderservice.domain.OrderItem;
import com.orderservice.domain.Order;
import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "order_items")
public class OrderItemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String productId;

    @Column(nullable = false)
    private String productName;

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private BigDecimal unitPrice;

    public OrderItemEntity() {
    }

    public OrderItemEntity(String productId, String productName, int quantity, BigDecimal unitPrice) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public Order.OrderItem toDomain() {
        return new Order.OrderItem(productId, productName, quantity, unitPrice);
    }

    public static OrderItemEntity fromDomain(Order.OrderItem orderItem) {
        return new OrderItemEntity(
                orderItem.getProductId(),
                orderItem.getProductName(),
                orderItem.getQuantity(),
                orderItem.getUnitPrice()
        );
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/persistence/SpringDataOrderRepository.java ===
package com.orderservice.infrastructure.persistence;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface SpringDataOrderRepository extends JpaRepository<OrderEntity, UUID> {
}

// === ARCHIVO: api/src/main/java/com/orderservice/application/OrderService.java ===
package com.orderservice.application;

import com.orderservice.domain.Order;
import com.orderservice.domain.Order.OrderItem;
import com.orderservice.domain.Order.OrderStatus;
import com.orderservice.domain.OrderRepository;
import com.orderservice.infrastructure.aws.SQSOrderEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final SQSOrderEventPublisher eventPublisher;

    public OrderService(OrderRepository orderRepository, SQSOrderEventPublisher eventPublisher) {
        this.orderRepository = orderRepository;
        this.eventPublisher = eventPublisher;
    }

    @Transactional
    public Order createOrder(String customerId, List<OrderItem> items) {
        if (customerId == null || customerId.isBlank()) {
            throw new IllegalArgumentException("Customer ID cannot be null or empty");
        }
        if (items == null || items.isEmpty()) {
            throw new IllegalArgumentException("Order must contain at least one item");
        }

        for (OrderItem item : items) {
            if (item.getProductId() == null || item.getProductId().isBlank()) {
                throw new IllegalArgumentException("Product ID cannot be null or empty");
            }
            if (item.getQuantity() <= 0) {
                throw new IllegalArgumentException("Quantity must be positive");
            }
            if (item.getUnitPrice() == null || item.getUnitPrice().compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Unit price must be positive");
            }
        }

        Order order = new Order(
            UUID.randomUUID(),
            customerId,
            items,
            OrderStatus.PENDING
        );

        Order savedOrder = orderRepository.save(order);

        try {
            eventPublisher.publishOrderCreatedEvent(savedOrder);
        } catch (Exception e) {
            System.err.println("Failed to publish order created event: " + e.getMessage());
        }

        return savedOrder;
    }

    @Transactional(readOnly = true)
    public Optional<Order> getOrderById(UUID orderId) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        return orderRepository.findById(orderId);
    }

    @Transactional
    public Order updateOrderStatus(UUID orderId, OrderStatus newStatus) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        if (newStatus == null) {
            throw new IllegalArgumentException("Status cannot be null");
        }

        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty()) {
            throw new IllegalArgumentException("Order not found with ID: " + orderId);
        }

        Order order = orderOpt.get();
        OrderStatus previousStatus = order.getStatus();
        order.setStatus(newStatus);

        Order updatedOrder = orderRepository.save(order);

        try {
            eventPublisher.publishOrderStatusChangedEvent(updatedOrder, previousStatus);
        } catch (Exception e) {
            System.err.println("Failed to publish order status change event: " + e.getMessage());
        }

        return updatedOrder;
    }

    @Transactional(readOnly = true)
    public List<Order> getOrdersByCustomerId(String customerId) {
        if (customerId == null || customerId.isBlank()) {
            throw new IllegalArgumentException("Customer ID cannot be null or empty");
        }
        return List.of();
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/aws/SQSOrderEventPublisher.java ===
package com.orderservice.infrastructure.aws;

import com.orderservice.domain.Order;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import software.amazon.awssdk.services.sqs.SqsAsyncClient;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;
import software.amazon.awssdk.services.sqs.model.SendMessageResponse;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

@Component
public class SQSOrderEventPublisher {

    private static final Logger log = LoggerFactory.getLogger(SQSOrderEventPublisher.class);

    private final SqsAsyncClient sqsAsyncClient;
    private final String queueUrl;

    public SQSOrderEventPublisher(
            SqsAsyncClient sqsAsyncClient,
            @Value("${aws.sqs.queue-url:}") String queueUrl) {
        this.sqsAsyncClient = sqsAsyncClient;
        this.queueUrl = queueUrl;
    }

    public CompletableFuture<SendMessageResponse> publishOrderCreatedEvent(Order order) {
        if (queueUrl == null || queueUrl.isBlank()) {
            log.warn("SQS queue URL not configured, skipping event publication for order: {}", order.getId());
            return CompletableFuture.completedFuture(null);
        }

        Map<String, Object> eventPayload = buildOrderEventPayload(order);
        String messageBody = serializeToJson(eventPayload);

        SendMessageRequest request = SendMessageRequest.builder()
                .queueUrl(queueUrl)
                .messageBody(messageBody)
                .messageGroupId("order-events")
                .build();

        log.info("Publishing order created event for order ID: {}", order.getId());

        return sqsAsyncClient.sendMessage(request)
                .whenComplete((response, exception) -> {
                    if (exception != null) {
                        log.error("Failed to publish event for order: {}", order.getId(), exception);
                    } else {
                        log.info("Successfully published event for order: {}. MessageId: {}",
                                order.getId(), response.messageId());
                    }
                });
    }

    private Map<String, Object> buildOrderEventPayload(Order order) {
        Map<String, Object> payload = new HashMap<>();
        payload.put("eventType", "ORDER_CREATED");
        payload.put("orderId", order.getId().toString());
        payload.put("customerId", order.getCustomerId());
        payload.put("totalAmount", order.getTotalAmount().toString());
        payload.put("status", order.getStatus().name());
        payload.put("createdAt", order.getCreatedAt().toString());

        Map<String, Object> items = new HashMap<>();
        order.getItems().forEach(item -> {
            Map<String, Object> itemData = new HashMap<>();
            itemData.put("productId", item.getProductId());
            itemData.put("productName", item.getProductName());
            itemData.put("quantity", item.getQuantity());
            itemData.put("unitPrice", item.getUnitPrice().toString());
            items.put(item.getProductId(), itemData);
        });
        payload.put("items", items);

        return payload;
    }

    private String serializeToJson(Map<String, Object> payload) {
        StringBuilder json = new StringBuilder("{");
        int count = 0;
        for (Map.Entry<String, Object> entry : payload.entrySet()) {
            if (count > 0) {
                json.append(",");
            }
            json.append("\"").append(entry.getKey()).append("\":");
            json.append(serializeValue(entry.getValue()));
            count++;
        }
        json.append("}");
        return json.toString();
    }

    private String serializeValue(Object value) {
        if (value == null) {
            return "null";
        } else if (value instanceof String) {
            return "\"" + escapeJsonString((String) value) + "\"";
        } else if (value instanceof Number) {
            return value.toString();
        } else if (value instanceof Map) {
            return serializeToJson((Map<String, Object>) value);
        } else {
            return "\"" + value.toString() + "\"";
        }
    }

    private String escapeJsonString(String value) {
        return value.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}

// === ARCHIVO: api/src/main/java/com/orderservice/infrastructure/web/OrderController.java ===
package com.orderservice.infrastructure.web;

import com.orderservice.application.OrderService;
import com.orderservice.domain.Order;
import com.orderservice.domain.Order.OrderItem;
import com.orderservice.domain.Order.OrderStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private static final Logger log = LoggerFactory.getLogger(OrderController.class);

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponseDTO> createOrder(@RequestBody OrderRequestDTO request) {
        log.info("Received create order request for customer: {}", request.customerId());

        List<OrderItem> items = request.items().stream()
                .map(itemDTO -> new OrderItem(
                        itemDTO.productId(),
                        itemDTO.productName(),
                        itemDTO.quantity(),
                        itemDTO.unitPrice()))
                .toList();

        Order createdOrder = orderService.createOrder(request.customerId(), items);

        log.info("Order created successfully with ID: {}", createdOrder.getId());

        OrderResponseDTO response = toResponseDTO(createdOrder);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDTO> getOrder(@PathVariable UUID id) {
        log.info("Received get order request for ID: {}", id);

        return orderService.getOrderById(id)
                .map(order -> {
                    log.info("Order found for ID: {}", id);
                    return ResponseEntity.ok(toResponseDTO(order));
                })
                .orElseGet(() -> {
                    log.warn("Order not found for ID: {}", id);
                    return ResponseEntity.notFound().build();
                });
    }

    private OrderResponseDTO toResponseDTO(Order order) {
        List<OrderItemDTO> itemDTOs = order.getItems().stream()
                .map(item -> new OrderItemDTO(
                        item.getProductId(),
                        item.getProductName(),
                        item.getQuantity(),
                        item.getUnitPrice()))
                .toList();

        return new OrderResponseDTO(
                order.getId(),
                order.getCustomerId(),
                itemDTOs,
                order.getStatus().name(),
                order.getCreatedAt().toString(),
                order.getUpdatedAt() != null ? order.getUpdatedAt().toString() : null,
                order.getTotalAmount());
    }

    public record OrderRequestDTO(String customerId, List<OrderItemDTO> items) {}

    public record OrderItemDTO(String productId, String productName, int quantity, BigDecimal unitPrice) {}

    public record OrderResponseDTO(
            UUID id,
            String customerId,
            List<OrderItemDTO> items,
            String status,
            String createdAt,
            String updatedAt,
            BigDecimal totalAmount) {}
}

// === ARCHIVO: api/src/main/resources/db/migration/V1__Initial_schema.sql ===
-- Script de migración inicial para el esquema de base de datos del servicio de órdenes
-- Crea las tablas necesarias para persistir órdenes y sus elementos
-- Versión: V1__Initial_schema.sql

-- Tabla principal de órdenes
CREATE TABLE orders (
    id UUID PRIMARY KEY,
    customer_id VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT uk_orders_id UNIQUE (id)
);

-- Tabla de elementos de orden (relación uno a muchos con orders)
CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id UUID NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    product_name VARCHAR(500) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(19, 2) NOT NULL CHECK (unit_price >= 0.00),
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) 
        REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uk_order_items_order_product UNIQUE (order_id, product_id)
);

-- Índice para búsquedas por customer_id
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- Índice para búsquedas por status
CREATE INDEX idx_orders_status ON orders(status);

-- Índice para búsquedas por fecha de creación
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);

-- Índice para búsquedas de items por order_id
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Índice para búsquedas de items por product_id
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Función para actualizar automáticamente updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para actualizar updated_at en la tabla orders
CREATE TRIGGER update_orders_updated_at
    BEFORE UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger para actualizar updated_at en la tabla orders cuando se modifica un item
CREATE TRIGGER update_orders_updated_at_on_item_change
    AFTER INSERT OR UPDATE OR DELETE ON order_items
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Comentarios para documentación del esquema
COMMENT ON TABLE orders IS 'Almacena las órdenes del sistema de ventas';
COMMENT ON TABLE order_items IS 'Almacena los elementos (productos) de cada orden';
COMMENT ON COLUMN orders.customer_id IS 'Identificador único del cliente que realizó la orden';
COMMENT ON COLUMN orders.status IS 'Estado de la orden: PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED, CANCELLED';
COMMENT ON COLUMN orders.total_amount IS 'Monto total de la orden en formato decimal con 2 decimales';
COMMENT ON COLUMN order_items.quantity IS 'Cantidad de unidades del producto en esta línea de orden';
COMMENT ON COLUMN order_items.unit_price IS 'Precio unitario del producto en el momento de la orden';
```
