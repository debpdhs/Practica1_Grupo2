#!/bin/bash
set -e

echo "🧹 Limpiando infraestructura Practica1 Grupo2..."

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

# Detener y eliminar contenedores
cleanup_containers() {
    log "Deteniendo contenedores..."
    docker compose down --remove-orphans --volumes 2>/dev/null || true
    log "✅ Contenedores detenidos"
}

# Limpiar imágenes (opcional)
cleanup_images() {
    if [ "$1" = "--images" ]; then
        log "Eliminando imágenes Docker..."
        docker rmi practica1-grupo2:latest 2>/dev/null || true
        log "✅ Imágenes eliminadas"
    fi
}

# Limpiar Terraform (si existe)
cleanup_terraform() {
    if [ -d "infrastructure/terraform" ] && [ -f "infrastructure/terraform/.terraform.lock.hcl" ]; then
        log "Limpiando estado de Terraform..."
        cd infrastructure/terraform
        terraform destroy -auto-approve 2>/dev/null || true
        rm -rf .terraform .terraform.lock.hcl terraform.tfstate* 2>/dev/null || true
        cd ../..
        log "✅ Estado de Terraform limpiado"
    fi
}

main() {
    log "=== Limpieza de Infraestructura ==="
    
    cleanup_containers
    cleanup_terraform
    cleanup_images "$1"
    
    log "🎉 Limpieza completada!"
}

main "$@"