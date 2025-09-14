# Practica1_Grupo2 - Desplegar Infraestructura

Este proyecto implementa una solución completa para el despliegue de infraestructura utilizando contenedores Docker, orquestación con Docker Compose, Infrastructure as Code con Terraform, y automatización con CI/CD.

## 🏗️ Arquitectura

La infraestructura incluye:
- **Aplicación Web**: Servidor Nginx sirviendo contenido estático
- **Contenedores Docker**: Aplicación containerizada para portabilidad
- **Orquestación**: Docker Compose para gestión de servicios
- **Infrastructure as Code**: Terraform para automatización
- **CI/CD Pipeline**: GitHub Actions para integración continua

## 🚀 Inicio Rápido

### Prerrequisitos

- Docker (>= 20.0)
- Docker Compose (>= 2.0)
- Terraform (>= 1.0) - Opcional
- Git

### Despliegue Automático

```bash
# Clonar el repositorio
git clone https://github.com/debpdhs/Practica1_Grupo2.git
cd Practica1_Grupo2

# Ejecutar script de despliegue
./infrastructure/scripts/deploy.sh
```

### Despliegue Manual

```bash
# Construir la imagen
docker build -t practica1-grupo2 .

# Desplegar con Docker Compose
docker compose up -d

# Verificar el despliegue
curl http://localhost:8080
```

## 📁 Estructura del Proyecto

```
Practica1_Grupo2/
├── src/                          # Código fuente de la aplicación web
│   └── index.html               # Página principal
├── infrastructure/
│   ├── terraform/               # Infrastructure as Code
│   │   ├── main.tf             # Configuración principal
│   │   ├── variables.tf        # Variables
│   │   └── outputs.tf          # Outputs
│   └── scripts/                # Scripts de automatización
│       ├── deploy.sh           # Script de despliegue
│       └── cleanup.sh          # Script de limpieza
├── .github/
│   └── workflows/
│       └── deploy.yml          # Pipeline CI/CD
├── Dockerfile                  # Imagen de contenedor
├── docker-compose.yml         # Orquestación de servicios
├── .env.example              # Variables de entorno de ejemplo
└── README.md                 # Esta documentación
```

## 🔧 Comandos Útiles

### Docker

```bash
# Ver contenedores en ejecución
docker compose ps

# Ver logs
docker compose logs -f

# Detener servicios
docker compose down

# Reconstruir imágenes
docker compose build --no-cache
```

### Terraform (Opcional)

```bash
# Inicializar Terraform
cd infrastructure/terraform
terraform init

# Planificar cambios
terraform plan

# Aplicar cambios
terraform apply

# Destruir infraestructura
terraform destroy
```

### Scripts de Automatización

```bash
# Desplegar infraestructura
./infrastructure/scripts/deploy.sh

# Limpiar recursos
./infrastructure/scripts/cleanup.sh

# Limpiar incluyendo imágenes Docker
./infrastructure/scripts/cleanup.sh --images
```

## 🌐 Acceso a la Aplicación

Una vez desplegada, la aplicación estará disponible en:
- **URL Local**: http://localhost:8080
- **Estado**: La página mostrará el estado del despliegue
- **Información**: Detalles de la infraestructura desplegada

## 📊 Monitoreo y Logs

### Ver Logs en Tiempo Real
```bash
docker compose logs -f web
```

### Estado de Contenedores
```bash
docker compose ps
```

### Estadísticas de Recursos
```bash
docker stats
```

## 🔐 Configuración

### Variables de Entorno

Copia el archivo de ejemplo y ajusta las configuraciones:

```bash
cp .env.example .env
# Editar .env con tus configuraciones específicas
```

### Personalización

- **Puerto**: Modifica el puerto en `docker-compose.yml`
- **Contenido**: Actualiza archivos en el directorio `src/`
- **Configuración Nginx**: Personaliza en el `Dockerfile`

## 🧪 Testing

El proyecto incluye verificaciones automáticas:

```bash
# El pipeline CI/CD ejecuta automáticamente:
# - Construcción de imagen Docker
# - Test de conectividad
# - Validación de estructura de archivos
```

## 🚨 Solución de Problemas

### Puerto ya en uso
```bash
# Cambiar el puerto en docker-compose.yml
ports:
  - "8081:80"  # Usar puerto 8081 en lugar de 8080
```

### Contenedor no inicia
```bash
# Ver logs detallados
docker compose logs web

# Reconstruir imagen
docker compose build --no-cache web
docker compose up -d
```

### Limpiar completamente
```bash
./infrastructure/scripts/cleanup.sh --images
docker system prune -a
```

## 👥 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto es parte de un ejercicio académico para Practica1_Grupo2.

## 📞 Soporte

Para soporte y preguntas:
- Crear un issue en el repositorio
- Contactar al equipo de desarrollo

---

**Estado del Proyecto**: ✅ Activo y en desarrollo

**Última Actualización**: 2025
