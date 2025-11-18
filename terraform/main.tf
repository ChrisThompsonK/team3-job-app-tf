resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}-${var.environment}-rg"
  location = var.region
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
# MANAGED IDENTITY - For container apps
# ============================================
resource "azurerm_user_assigned_identity" "container_apps" {
  name                = "mi-${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# ============================================
# RBAC - Managed Identity access to Key Vault secrets
# ============================================
resource "azurerm_role_assignment" "mi_keyvault_secrets" {
  scope              = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id       = azurerm_user_assigned_identity.container_apps.principal_id
}

# ============================================
# RBAC - Managed Identity access to ACR
# ============================================
resource "azurerm_role_assignment" "mi_acr_pull" {
  scope              = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/aiacademy-rg/providers/Microsoft.ContainerRegistry/registries/aiacademy25"
  role_definition_name = "AcrPull"
  principal_id       = azurerm_user_assigned_identity.container_apps.principal_id
}

