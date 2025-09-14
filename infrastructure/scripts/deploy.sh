#!/bin/bash
set -e

echo "🚀 Iniciando despliegue de Practica1 Grupo2..."

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para logging
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Verificar dependencias
check_dependencies() {
    log "Verificando dependencias..."
    
    if ! command -v docker &> /dev/null; then
        error "Docker no está instalado. Por favor, instala Docker primero."
    fi
    
    if ! docker compose version &> /dev/null; then
        error "Docker Compose no está disponible. Por favor, instala Docker Compose primero."
    fi
    
    log "✅ Todas las dependencias están disponibles"
}

# Construir imagen
build_image() {
    log "Construyendo imagen Docker..."
    docker build -t practica1-grupo2:latest . || error "Falló la construcción de la imagen"
    log "✅ Imagen construida exitosamente"
}

# Desplegar con Docker Compose
deploy_with_compose() {
    log "Desplegando con Docker Compose..."
    docker compose down --remove-orphans 2>/dev/null || true
    docker compose up -d || error "Falló el despliegue"
    log "✅ Aplicación desplegada exitosamente"
}

# Verificar despliegue
verify_deployment() {
    log "Verificando despliegue..."
    sleep 5
    
    if curl -f http://localhost:8080 > /dev/null 2>&1; then
        log "✅ Aplicación está respondiendo en http://localhost:8080"
    else
        warning "La aplicación puede necesitar más tiempo para iniciarse"
        warning "Verifica manualmente en http://localhost:8080"
    fi
}

# Mostrar estado
show_status() {
    log "Estado de los contenedores:"
    docker compose ps
    echo ""
    log "Para ver los logs: docker compose logs -f"
    log "Para detener: docker compose down"
    log "URL de la aplicación: http://localhost:8080"
}

# Función principal
main() {
    log "=== Despliegue de Infraestructura Practica1 Grupo2 ==="
    
    check_dependencies
    build_image
    deploy_with_compose
    verify_deployment
    show_status
    
    log "🎉 Despliegue completado exitosamente!"
}

# Ejecutar función principal
main "$@"