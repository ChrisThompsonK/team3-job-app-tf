output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "Resource group name"
}

output "resource_group_id" {
  value       = azurerm_resource_group.main.id
  description = "Resource group ID"
}

output "key_vault_id" {
  value       = azurerm_key_vault.main.id
  description = "Key Vault ID"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.main.vault_uri
  description = "Key Vault URI for secret references"
}

output "key_vault_name" {
  value       = azurerm_key_vault.main.name
  description = "Key Vault name"
}

output "managed_identity_id" {
  value       = azurerm_user_assigned_identity.container_apps.id
  description = "Managed Identity ID"
}

output "managed_identity_principal_id" {
  value       = azurerm_user_assigned_identity.container_apps.principal_id
  description = "Managed Identity Principal ID"
}
