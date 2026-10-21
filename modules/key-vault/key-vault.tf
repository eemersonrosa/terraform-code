provider "azurerm" {
  features {}
  alias                      = "ss_sub"
  subscription_id            = var.subscription_id
  skip_provider_registration = true
}

data "azurerm_key_vault" "kv" {
  provider            = azurerm.ss_sub
  name                = var.key_vault_name
  resource_group_name = var.ss_resource_group_name
}

data "azurerm_key_vault_secret" "ssh_key" {
  name         = "ssh-vmss"
  key_vault_id = data.azurerm_key_vault.kv.id
}
