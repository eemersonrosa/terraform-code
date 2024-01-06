variable "resource_prefix" {
  type        = string
  description = "A prefix used in resource names for better identification."
}

variable "env" {
  type        = string
  description = "The chosen deployment environment (e.g., dev, prod)."
}

variable "location" {
  type        = string
  description = "The Azure region or location where resources will be deployed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group for your deployment."
}

variable "sql_password" {
  type        = string
  description = "The SQL password to be used for database connections."
}
