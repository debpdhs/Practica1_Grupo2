variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
  default     = "practica1-grupo2"
}

variable "app_port" {
  description = "Puerto externo de la aplicación"
  type        = number
  default     = 8080
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "development"
}