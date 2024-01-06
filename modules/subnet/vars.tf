variable "resource_prefix" {
  type        = string
  description = "A prefix for naming resources."
}

variable "env" {
  type        = string
  description = "Environment identifier."
}

variable "location" {
  type        = string
  description = "Main resource location."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group."
}

variable "vnet_subnet" {
  type        = list(string)
  description = "Address space for the Virtual Network subnet."
  # You may consider setting a default value here if applicable.
}

variable "vnet_main_name" {
  type        = string
  description = "Name of the Azure Virtual Network."
}
