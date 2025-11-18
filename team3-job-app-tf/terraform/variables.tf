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
