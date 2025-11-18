resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}-${var.environment}-rg"
  location = var.region
}

# ============================================
# KEY VAULT - For storing application secrets
# ============================================
resource "azurerm_key_vault" "main" {
  name                       = "kv-team3-jobapp-${var.environment}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  rbac_authorization_enabled = true
}

# ============================================
# RBAC - Current user has admin access
# ============================================
resource "azurerm_role_assignment" "current_user_admin" {
  scope              = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id       = data.azurerm_client_config.current.object_id
}
