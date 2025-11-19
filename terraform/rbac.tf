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
