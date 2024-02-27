variable "resource_group_location" {
  type        = string
  default     = "swedencentral"
  description = "Location of the resource group."
}

variable "env" {
  description = "The name of the environment to be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the SQL Server"
  type        = string
}

variable "version" {
  description = "The version of the SQL Server"
  default     = "12.0"
}

variable "admin_login" {
  description = "The name of the administrator to login to the SQL Server"
  type        = string
}

variable "admin_password" {
  description = "The password for the administrator to login to the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}