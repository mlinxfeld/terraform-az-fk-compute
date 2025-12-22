locals {
  nic_ipconfig_name = "ipconfig1"
}

# =========================
# Single VM
# =========================

resource "azurerm_network_interface" "vm_nic" {
  count               = var.deployment_mode == "vm" ? 1 : 0
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = local.nic_ipconfig_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.deployment_mode == "vm" ? 1 : 0
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.vm_nic[0].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = var.tags
}

resource "azurerm_network_interface_backend_address_pool_association" "vm_lb_attach" {
  count = var.deployment_mode == "vm" && var.lb_attachment != null ? 1 : 0

  network_interface_id    = azurerm_network_interface.vm_nic[0].id
  ip_configuration_name   = local.nic_ipconfig_name
  backend_address_pool_id = var.lb_attachment.backend_pool_id
}

# =========================
# VM Scale Set
# =========================

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  count               = var.deployment_mode == "vmss" ? 1 : 0
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_size
  instances           = var.instance_count
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.name}-nic"
    primary = true

    ip_configuration {
      name      = local.nic_ipconfig_name
      primary  = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = (
        var.lb_attachment != null ? [var.lb_attachment.backend_pool_id] : []
      )
    }
  }

  tags = var.tags
}

# =========================
# Autoscale (VMSS only)
# =========================

resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  count               = var.deployment_mode == "vmss" && var.enable_autoscale ? 1 : 0
  name                = "${var.name}-autoscale"
  location            = var.location
  resource_group_name = var.resource_group_name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss[0].id

  profile {
    name = "default"

    capacity {
      minimum = tostring(var.autoscale_min_instances)
      maximum = tostring(var.autoscale_max_instances)
      default = tostring(var.instance_count)
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss[0].id
        operator           = "GreaterThan"
        threshold          = var.autoscale_cpu_scale_out_threshold
        time_aggregation   = "Average"
        statistic          = "Average"
        time_window        = "PT5M"
        time_grain         = "PT1M"
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = var.autoscale_cooldown
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss[0].id
        operator           = "LessThan"
        threshold          = var.autoscale_cpu_scale_in_threshold
        time_aggregation   = "Average"
        statistic          = "Average"
        time_window        = "PT5M"
        time_grain         = "PT1M"
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = var.autoscale_cooldown
      }
    }
  }

  tags = var.tags
}

