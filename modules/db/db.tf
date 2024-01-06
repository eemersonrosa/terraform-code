resource "azurerm_mssql_server" "mssql-server-main" {
  name                         = "mssql-${var.resource_prefix}-${var.location}-001"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = var.sql_password
  minimum_tls_version          = "1.2"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    env = var.env
  }
}

resource "azurerm_mssql_database" "mssql-db-main" {
  name         = "db-${var.resource_prefix}-${var.location}-001"
  server_id    = azurerm_mssql_server.mssql-server-main.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  sku_name     = "Basic"

  tags = {
    env = var.env
  }
}
