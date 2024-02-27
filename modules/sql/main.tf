# ------------------------------------------------------------------------------------------------------
# Deploy sql server
# ------------------------------------------------------------------------------------------------------
resource "azurecaf_name" "sqlserver_name" {
  name          = "sqlserver"
  resource_type = "azurerm_sql_server"
  prefixes      = [var.env]
  random_length = 3
  clean_input   = true
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = azurecaf_name.sqlserver_name.result
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  tags                         = { env : var.env }
}

# ------------------------------------------------------------------------------------------------------
# Deploy sql databases
# ------------------------------------------------------------------------------------------------------
resource "azurerm_sql_database" "sqldatabase" {
  name                = var.sql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  location            = var.resource_group_location
  tags                = { env : var.env }
}