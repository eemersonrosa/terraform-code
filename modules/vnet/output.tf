output "vnet_main_name" {
  description = "Name of the main Azure Virtual Network"
  value       = azurerm_virtual_network.main-vnet.name
}

output "vnet_main_id" {
  description = "Azure Resource ID of the main Virtual Network"
  value       = azurerm_virtual_network.main-vnet.id
}
