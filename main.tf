terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.86.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstatesa010"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Main Resource-Group Configuration
module "resource-group" {
  source          = "./modules/resource-group"
  resource_prefix = var.resource_prefix
  env             = var.env
  location        = var.main_location
}

# Virtual Network Configuration
module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = module.resource-group.main_rg_name
  resource_prefix     = var.resource_prefix
  env                 = var.env
  location            = var.main_location
  vnet_address_space  = var.vnet_address_space
}

# Subnet Configuration
module "subnet" {
  source              = "./modules/subnet"
  resource_group_name = module.resource-group.main_rg_name
  resource_prefix     = var.resource_prefix
  env                 = var.env
  location            = var.main_location
  vnet_subnet         = var.vnet_subnet
  vnet_main_name      = module.vnet.vnet_main_name
}

# Network Security Group Configuration
module "nsg" {
  source               = "./modules/nsg"
  resource_group_name  = module.resource-group.main_rg_name
  resource_prefix      = var.resource_prefix
  env                  = var.env
  location             = var.main_location
  authorized_ip_ranges = var.authorized_ip_ranges
  subnet_main_id       = module.subnet.sub_main_id
}

# Key Vault Configuration
module "key-vault" {
  source                 = "./modules/key-vault"
  resource_group_name    = module.resource-group.main_rg_name
  resource_prefix        = var.resource_prefix
  env                    = var.env
  location               = var.main_location
  ss_resource_group_name = var.ss_resource_group_name
  subscription_id        = var.subscription_id
  key_vault_name         = var.key_vault_name
}

# Storage Account Configuration
module "storage-account" {
  source               = "./modules/storage-account"
  resource_group_name  = module.resource-group.main_rg_name
  resource_prefix      = var.resource_prefix
  env                  = var.env
  location             = var.main_location
  folder_path          = "./assets"
  authorized_ip_ranges = var.authorized_ip_ranges
  sub_main_id          = [module.subnet.sub_main_id]
}

# Scale Set Configuration
module "scale-set" {
  source              = "./modules/scale-set"
  resource_group_name = module.resource-group.main_rg_name
  resource_prefix     = var.resource_prefix
  env                 = var.env
  location            = var.main_location
  admin_password      = module.key-vault.vm_password
  sub_main_id         = module.subnet.sub_main_id
  ssh_key_vmss        = module.key-vault.ssh_key_vmss_value
}

# # SQL Server/DB Configuration
# module "db" {
#   source              = "./modules/db"
#   resource_group_name = module.resource-group.main_rg_name
#   resource_prefix     = var.resource_prefix
#   env                 = var.env
#   location            = var.main_location
#   sql_password        = module.key-vault.sql_password
# }

# module "k8s" {
#   source = "./modules/k8s"

#   resource_group_name = module.resource-group.main_rg_name
#   resource_prefix     = var.resource_prefix
#   location            = var.main_location
#   env                 = var.env
# }
