variable "resource_prefix" {
  type        = string
  description = "A prefix used in resource names for better identification."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group for your deployment."
}

variable "env" {
  type        = string
  description = "The chosen deployment environment (e.g., dev, prod)."
}

variable "location" {
  type        = string
  description = "The Azure location where resources will be deployed."
}

variable "ss_resource_group_name" {
  type        = string
  description = "The name of the shared services resource group."
}

# variable "ss_location" {
#   type        = string
#   description = "The location of the shared services resource group."
# }

variable "subscription_id" {
  type        = string
  description = "The subscription ID for shared services."
}

variable "key_vault_name" {
  type        = string
  description = "The name of the key vault in the shared services subscription."
}
