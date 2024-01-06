# Resource Prefix
variable "resource_prefix" {
  type        = string
  description = "A prefix used for naming resources. (e.g., 'myapp' or 'dev')"
  default     = "erg"
}

# Environment Identifier
variable "env" {
  type        = string
  description = "An identifier for the environment. (e.g., 'development' or 'production')"
  default     = "dev"
}

# Main Resource Location
variable "main_location" {
  type        = string
  default     = "eastus"
  description = "The primary location for deploying main resources. (e.g., 'eastus')"
}

# Virtual Network Address Space
variable "vnet_address_space" {
  type        = list(string)
  description = "The address space(s) for the Virtual Network. Must be a list of CIDR notations."
}

# Virtual Network Subnet Configuration
variable "vnet_subnet" {
  type        = list(string)
  description = "Configuration for subnets within the Virtual Network."
}

variable "authorized_ip_ranges" {
  type        = list(string)
  description = "List of authorized IP ranges"
}

# Shared Services Resource Group Name
variable "ss_resource_group_name" {
  type        = string
  description = "The name of the shared services resource group."
}

# Shared Storage Account Name
variable "ss_storage_account_name" {
  type        = string
  description = "The name of the shared storage account."
}

# Shared Services Location
variable "ss_location" {
  type        = string
  description = "The location for the shared services resource group. (e.g., 'eastus')"
}

# Shared Services Subscription ID
variable "subscription_id" {
  type        = string
  description = "The subscription ID for the shared services."
}

# Key Vault Name
variable "key_vault_name" {
  type        = string
  description = "The name of the key vault in the shared services subscription."
}
