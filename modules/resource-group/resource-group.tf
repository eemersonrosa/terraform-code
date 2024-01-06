resource "azurerm_resource_group" "main_rg" {
  name     = "rg-${var.resource_prefix}-${var.location}-001"
  location = var.location
}
