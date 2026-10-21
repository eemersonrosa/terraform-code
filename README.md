# Terraform Code — Azure VM scale set lab

Terraform practice project on **Azure**: a small, locked-down network and an
autoscaling Ubuntu VM scale set, split into one module per resource type.

## What it builds

| Module | Resources |
| --- | --- |
| `resource-group` | `rg-<prefix>-<location>-001` |
| `vnet`, `subnet` | Virtual network and one subnet (address space from variables). |
| `nsg` | Network security group on the subnet that allows inbound traffic **only from `authorized_ip_ranges`**. |
| `key-vault` | Reads the scale set's SSH public key (`ssh-vmss`) from a Key Vault in a separate shared-services subscription (second, aliased `azurerm` provider). |
| `scale-set` | Ubuntu 22.04 `Standard_B1s` scale set, SSH-key login only, public IPs from a prefix, system-assigned identity, and CPU autoscale (1–3 instances: +1 above 75 %, −1 below 25 %). `linux-config.sh` runs as cloud-init custom data: installs Docker, adds `adminuser` to the `docker` group, sets the hostname. |

State lives in the `azurerm` backend (`tf-state-rg` / `tfstatesa010` in
`main.tf`; change it to your own storage account).

## Running it

```bash
az login
cp terraform.tfvars.example terraform.tfvars   # fill in your values
terraform init
terraform plan
```

Defaults: `resource_prefix = "erg"`, `env = "dev"`, `main_location = "eastus"`.
