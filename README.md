# Aprovisionamiento de infraestructura con Terraform para el servicio de ordenes

El servicio de ordenes requiere una infraestructura robusta y escalable en AWS. Tu tarea es aprovisionar esta infraestructura utilizando Terraform. La infraestructura debe ser versionada y gestionada de manera eficiente para asegurar la disponibilidad y rendimiento del servicio.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Maven 3.9+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `mvn compile` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform y definir los recursos básicos necesarios para el servicio de ordenes.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configura Terraform para trabajar con tu cuenta de AWS.
- Define los recursos básicos (VPC, subredes, grupos de seguridad) necesarios para el servicio de ordenes.
- Asegura que los recursos definidos cumplan con los estándares de seguridad y rendimiento del dominio.

**Entregable:** Configuración de Terraform que define los recursos básicos para el servicio de ordenes.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los requisitos de escalabilidad y disponibilidad del servicio.
- Revisa las mejores prácticas para la configuración de VPC y subredes en AWS.

</details>

### Fase 2: Aprovisionamiento de servicios adicionales

**Objetivo:** Aprovisionar servicios adicionales (como bases de datos, servicios de mensajería) necesarios para el funcionamiento del servicio de ordenes.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Aprovisiona una base de datos relacional (RDS) y un servicio de mensajería (SQS) utilizando Terraform.
- Configura las políticas de acceso y permisos necesarios para que el servicio de ordenes interactúe con estos servicios.
- Asegura que los servicios aprovisionados cumplan con los requisitos de rendimiento y disponibilidad del dominio.

**Entregable:** Configuración de Terraform que aprovisiona servicios adicionales para el servicio de ordenes.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los patrones de acceso y uso de la base de datos y el servicio de mensajería.
- Revisa las mejores prácticas para la configuración de RDS y SQS en AWS.

</details>

### Fase 3: Versionado y gestión de la infraestructura

**Objetivo:** Versionar y gestionar la infraestructura aprovisionada utilizando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Versiona la configuración de Terraform en un repositorio de código.
- Implementa un pipeline de CI/CD para automatizar el despliegue de la infraestructura.
- Asegura que el pipeline de CI/CD cumpla con los estándares de calidad y rendimiento del dominio.
- Documenta el proceso de versionado y gestión de la infraestructura.

**Entregable:** Configuración versionada de Terraform y pipeline de CI/CD para el despliegue de la infraestructura.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las mejores prácticas para el versionado y gestión de código.
- Revisa las herramientas y servicios de AWS para automatizar el despliegue de infraestructura.
- Java: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y por qué se usa en este reto?
- **paraQueSirve**: ¿Para qué sirve aprovisionar infraestructura con Terraform en el contexto del servicio de ordenes?
- **comoSeUsa**: ¿Cómo se usa Terraform para definir y aprovisionar recursos en AWS?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar infraestructura con Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el versionado y la gestión de la infraestructura aprovisionada con Terraform?

## Criterios de Evaluacion

- Configuración inicial de Terraform que define los recursos básicos para el servicio de ordenes.
- Aprovisionamiento de servicios adicionales (RDS, SQS) utilizando Terraform.
- Versionado y gestión de la infraestructura aprovisionada con Terraform.
- Implementación de un pipeline de CI/CD para automatizar el despliegue de la infraestructura.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
