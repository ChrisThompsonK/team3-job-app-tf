# ============================================
# MANAGED IDENTITY - Frontend
# ============================================
resource "azurerm_user_assigned_identity" "frontend" {
  name                = "mi-${var.app_name}-frontend-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# ============================================
# MANAGED IDENTITY - Backend
# ============================================
resource "azurerm_user_assigned_identity" "backend" {
  name                = "mi-${var.app_name}-backend-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}
