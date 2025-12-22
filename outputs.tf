output "deployment_mode" {
  value = var.deployment_mode
}

# -------- VM --------

output "vm_id" {
  value       = try(azurerm_linux_virtual_machine.vm[0].id, null)
  description = "VM resource ID"
}

output "vm_private_ip" {
  value       = try(azurerm_network_interface.vm_nic[0].private_ip_address, null)
  description = "Private IP address of the VM"
}

output "backend_nic_ids" {
  value       = var.deployment_mode == "vm" ? [azurerm_network_interface.vm_nic[0].id] : []
  description = "NIC IDs usable as LB backend targets"
}

# -------- VMSS --------

output "vmss_id" {
  value       = try(azurerm_linux_virtual_machine_scale_set.vmss[0].id, null)
  description = "VM Scale Set ID"
}

output "autoscale_setting_id" {
  value       = try(azurerm_monitor_autoscale_setting.vmss_autoscale[0].id, null)
  description = "Autoscale setting ID (if enabled)"
}

output "attached_backend_pool_ids" {
  value = (
    var.lb_attachment != null ? [var.lb_attachment.backend_pool_id] : []
  )
  description = "Backend pool IDs this compute instance is attached to"
}

