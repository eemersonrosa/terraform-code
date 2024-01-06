output "sql_password" {
  value       = azurerm_key_vault_secret.sql_pass.value
  sensitive   = true
  description = "The SQL password retrieved from Azure Key Vault."
}

output "vm_password" {
  value       = azurerm_key_vault_secret.vm_pass.value
  sensitive   = true
  description = "The VM password retrieved from Azure Key Vault."
}

# output "sql_password_secret_name" {
#   value       = azurerm_key_vault_secret.sql_pass.name
#   sensitive   = true
#   description = "The name of the Azure Key Vault secret for SQL password."
# }

# output "vm_password_secret_name" {
#   value       = azurerm_key_vault_secret.vm_pass.name
#   sensitive   = true
#   description = "The name of the Azure Key Vault secret for VM password."
# }

output "ssh_key_vmss_value" {
  value = data.azurerm_key_vault_secret.ssh_key.value
}
