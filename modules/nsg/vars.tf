variable "resource_prefix" {
  type        = string
  description = "A prefix used in resource names for better identification"
}

variable "env" {
  type        = string
  description = "The environment or deployment stage (e.g., dev, prod)"
}

variable "location" {
  type        = string
  description = "The Azure region or location where resources will be deployed"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group"
}

variable "authorized_ip_ranges" {
  type        = list(string)
  description = "A list of authorized IP ranges for network security"
}

variable "subnet_main_id" {
  type        = string
  description = "The ID of the main Azure Subnet"
}
