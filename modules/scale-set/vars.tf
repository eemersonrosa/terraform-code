variable "resource_prefix" {
  type        = string
  description = "A prefix for naming resources"
}

variable "env" {
  type        = string
  description = "The environment for the resources"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group"
}

variable "sub_main_id" {
  type        = string
  description = "The ID of the main Azure Subnet"
}

variable "admin_password" {
  type        = string
  description = "The administrator password for VMs (if applicable)"
}

variable "ssh_key_vmss" {
  type        = string
  description = "SSH KEY stored in KeyVault for VM login"
}
