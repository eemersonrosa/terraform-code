output "ssh_key_vmss_value" {
  description = "SSH public key for the scale set, read from the shared Key Vault."
  value       = data.azurerm_key_vault_secret.ssh_key.value
}
