output "resource_group_name" {
  value = azurerm_resource_group.foggykitchen_rg.name
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "nva_vm_id" {
  value = module.compute.vm_id
}

output "nva_primary_private_ip" {
  value = module.compute.vm_private_ip
}

output "nva_private_ips" {
  value = module.compute.vm_private_ips
}

output "nva_nic_ids" {
  value = module.compute.vm_nic_ids
}

output "inside_nsg_id" {
  value = module.nsg_inside.id
}

output "outside_nsg_id" {
  value = module.nsg_outside.id
}
