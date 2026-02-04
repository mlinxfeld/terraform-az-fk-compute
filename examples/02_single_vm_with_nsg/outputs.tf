output "resource_group_name" {
  value       = azurerm_resource_group.foggykitchen_rg.name
  description = "Resource Group name"
}

output "vnet_id" {
  value       = module.vnet.vnet_id
  description = "VNet ID"
}

output "public_subnet_id" {
  value       = module.vnet.subnet_ids["fk-subnet-public"]
  description = "Public subnet ID"
}

output "nsg_id" {
  value       = module.nsg.id
  description = "Network Security Group ID"
}

output "vm_id" {
  value       = module.compute.vm_id
  description = "Virtual Machine ID"
}

output "vm_private_ip" {
  value       = module.compute.vm_private_ip
  description = "Private IP address of the VM"
}
