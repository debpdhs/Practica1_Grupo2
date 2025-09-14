# Terraform configuration for basic infrastructure
terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configure the Docker Provider
provider "docker" {}

# Create a docker image resource
resource "docker_image" "practica1" {
  name         = "practica1-grupo2:latest"
  build_context = "../.."
  dockerfile    = "Dockerfile"
}

# Create a container
resource "docker_container" "practica1_container" {
  image = docker_image.practica1.image_id
  name  = "practica1-web"
  
  ports {
    internal = 80
    external = 8080
  }
  
  restart = "unless-stopped"
}