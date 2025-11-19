variable "environment" {
  type    = string
  default = "dev"
}

variable "app_name" {
  type    = string
  default = "team3-job-app"
}

variable "region" {
  type    = string
  default = "UK South"
}

variable "acr_name" {
  type    = string
  default = "aiacademy25"
}

variable "acr_resource_group_name" {
  type    = string
  default = "container-registry"
}

variable "frontend_image" {
  type    = string
  default = "aiacademy25.azurecr.io/team3-job-app-frontend:latest"
}

variable "backend_image" {
  type    = string
  default = "aiacademy25.azurecr.io/team3-job-app-backend:latest"
}

variable "frontend_cpu" {
  type    = string
  default = "0.25"
}

variable "frontend_memory" {
  type    = string
  default = "0.5Gi"
}

variable "backend_cpu" {
  type    = string
  default = "0.25"
}

variable "backend_memory" {
  type    = string
  default = "0.5Gi"
}

```
