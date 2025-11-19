# ============================================
# CONTAINER APP - Frontend (Public-facing)
# ============================================
resource "azurerm_container_app" "frontend" {
  name                         = "ca-${var.app_name}-frontend-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.frontend.id]
  }

  template {
    container {
      name   = "frontend"
      image  = var.frontend_image
      cpu    = var.frontend_cpu
      memory = var.frontend_memory

      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }
    }

    min_replicas = 1
    max_replicas = 3
  }

  # Public-facing ingress
  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 3000
    transport                  = "http"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  registry {
    server               = "${var.acr_name}.azurecr.io"
    identity             = azurerm_user_assigned_identity.frontend.id
  }
}

# ============================================
# CONTAINER APP - Backend (Internal only)
# ============================================
resource "azurerm_container_app" "backend" {
  name                         = "ca-${var.app_name}-backend-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.backend.id]
  }

  template {
    container {
      name   = "backend"
      image  = var.backend_image
      cpu    = var.backend_cpu
      memory = var.backend_memory

      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }
    }

    min_replicas = 1
    max_replicas = 3
  }

  # Internal-only ingress (not publicly accessible)
  ingress {
    allow_insecure_connections = false
    external_enabled           = false
    target_port                = 3001
    transport                  = "http"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  registry {
    server               = "${var.acr_name}.azurecr.io"
    identity             = azurerm_user_assigned_identity.backend.id
  }
}
