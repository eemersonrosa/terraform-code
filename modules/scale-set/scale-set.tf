resource "azurerm_public_ip_prefix" "public-ip" {
  name                = "${var.resource_prefix}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_linux_virtual_machine_scale_set" "linux-vmss" {
  name                = "${var.resource_prefix}-vmss"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard_B1s"
  instances           = 1
  admin_username      = "adminuser"
  # admin_password                  = var.admin_password
  # disable_password_authentication = false

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_key_vmss
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(file("${path.module}/../storage-account/assets/linux-config.sh"))

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmss-net-${var.resource_prefix}-${lower(var.location)}"
    primary = true

    ip_configuration {
      primary   = true
      name      = "internal"
      subnet_id = var.sub_main_id

      public_ip_address {
        name                = "first"
        public_ip_prefix_id = azurerm_public_ip_prefix.public-ip.id
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    env = var.env
  }

}

resource "azurerm_monitor_autoscale_setting" "autoscale-config" {
  name                = "autoscale-config"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.linux-vmss.id

  profile {
    name = "AutoScale"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.linux-vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.linux-vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
