resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}-${var.environment}-rg"
  location = var.region
}

# ============================================
# DATA SOURCE - Get existing ACR
# ============================================
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
}

# ============================================
# KEY VAULT - For storing application secrets
# ============================================
resource "azurerm_key_vault" "main" {
  name                        = "kv-team3-jobapp-${var.environment}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
}

# ============================================
# CONTAINER APP ENVIRONMENT
# ============================================
resource "azurerm_container_app_environment" "main" {
  name                = "cae-${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

