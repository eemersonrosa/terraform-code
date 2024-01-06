resource "azurerm_virtual_network" "main-vnet" {
  name                = "vnet-${var.resource_prefix}-${var.location}-001"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
