output "sql_server_name" {
  description = "The name of the SQL Server"
  value       = azurerm_sql_server.sqlserver.name
}

output "sql_database_name" {
  description = "The name of the SQL Database"
  value       = azurerm_sql_database.sqldatabase.name
}