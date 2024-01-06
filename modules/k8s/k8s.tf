resource "azurerm_kubernetes_cluster" "k8s-main" {
  name                = "k8s-${var.resource_prefix}-${var.location}-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.resource_prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
