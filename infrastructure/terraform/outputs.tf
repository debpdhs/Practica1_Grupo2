output "container_id" {
  description = "ID del contenedor Docker"
  value       = docker_container.practica1_container.id
}

output "container_name" {
  description = "Nombre del contenedor"
  value       = docker_container.practica1_container.name
}

output "application_url" {
  description = "URL de la aplicación"
  value       = "http://localhost:8080"
}