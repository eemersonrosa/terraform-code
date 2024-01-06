variable "resource_prefix" {
  description = "A prefix for naming resources"
  type        = string
}

variable "env" {
  description = "Environment identifier"
  type        = string
}

variable "location" {
  description = "Main resource location"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the main resource group"
  type        = string
}
