resource "azurerm_subnet" "subnet-main" {
  name                 = "sub-${var.resource_prefix}-${var.location}-001"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_main_name
  address_prefixes     = var.vnet_subnet

  service_endpoints = ["Microsoft.Storage"]
}
