# Define the Azure Storage Account
resource "azurerm_storage_account" "stg-main" {
  name                     = "stg${var.resource_prefix}${lower(var.location)}001"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    env = var.env
  }
}

# Define the Storage Container
resource "azurerm_storage_container" "container-main" {
  name                  = "${var.resource_prefix}-scripts"
  storage_account_name  = azurerm_storage_account.stg-main.name
  container_access_type = "blob"
}

# Upload files to the Storage Container
resource "azurerm_storage_blob" "uploaded-files" {
  for_each               = fileset("${path.module}/${var.folder_path}", "*.*")
  name                   = each.key
  storage_account_name   = azurerm_storage_account.stg-main.name
  storage_container_name = azurerm_storage_container.container-main.name
  type                   = "Block"
  source                 = "${path.module}/${var.folder_path}/${each.key}"
}

# Define network rules for the Storage Account
resource "azurerm_storage_account_network_rules" "stg-net-rule" {
  storage_account_id = azurerm_storage_account.stg-main.id

  default_action             = "Deny"
  ip_rules                   = var.authorized_ip_ranges
  virtual_network_subnet_ids = var.sub_main_id
}
