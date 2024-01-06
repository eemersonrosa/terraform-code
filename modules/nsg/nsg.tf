resource "azurerm_network_security_group" "main_nsg" {
  name                = "nsg-${var.resource_prefix}-${var.location}-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowHomeLocalIP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = var.authorized_ip_ranges
    destination_address_prefix = "*"
  }
  tags = {
    env = var.env
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-sec-group" {
  subnet_id                 = var.subnet_main_id
  network_security_group_id = azurerm_network_security_group.main_nsg.id
}
