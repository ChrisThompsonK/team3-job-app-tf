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

# ============================================
# RBAC - Frontend MI access to Key Vault secrets
# ============================================
resource "azurerm_role_assignment" "frontend_keyvault_secrets" {
  scope              = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id       = azurerm_user_assigned_identity.frontend.principal_id
}

# ============================================
# RBAC - Frontend MI access to ACR
# ============================================
resource "azurerm_role_assignment" "frontend_acr_pull" {
  scope              = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id       = azurerm_user_assigned_identity.frontend.principal_id
}

# ============================================
# RBAC - Backend MI access to Key Vault secrets
# ============================================
resource "azurerm_role_assignment" "backend_keyvault_secrets" {
  scope              = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id       = azurerm_user_assigned_identity.backend.principal_id
}

# ============================================
# RBAC - Backend MI access to ACR
# ============================================
resource "azurerm_role_assignment" "backend_acr_pull" {
  scope              = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id       = azurerm_user_assigned_identity.backend.principal_id
}

