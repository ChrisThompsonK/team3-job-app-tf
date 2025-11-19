variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  default     = "dev"
}

variable "app_name" {
  type        = string
  description = "Application name"
  default     = "team3-job-app"
}

variable "region" {
  type        = string
  description = "Azure region"
  default     = "UK South"
}

variable "acr_name" {
  type        = string
  description = "Azure Container Registry name"
  default     = "aiacademy25"
}

variable "acr_resource_group_name" {
  type        = string
  description = "Resource group name where ACR exists"
  default     = "container-registry"
}
