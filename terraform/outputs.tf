output "frontend_url" {
  value = azurerm_container_app.frontend.ingress[0].fqdn
}

output "backend_fqdn" {
  value = azurerm_container_app.backend.ingress[0].fqdn
}

output "key_vault_name" {
  value = azurerm_key_vault.main.name
}
