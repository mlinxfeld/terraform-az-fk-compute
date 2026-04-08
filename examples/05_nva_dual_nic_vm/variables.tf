variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name for this example"
  type        = string
  default     = "fk-rg"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "fk-vnet-nva-dual-nic"
}

variable "vnet_address_space" {
  description = "VNet CIDR"
  type        = string
  default     = "10.20.0.0/16"
}

variable "subnets" {
  description = "Subnets used by the dual-NIC NVA VM"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {
    fk-subnet-inside = {
      address_prefixes = ["10.20.1.0/24"]
    }
    fk-subnet-outside = {
      address_prefixes = ["10.20.2.0/24"]
    }
  }
}

variable "nva_vm_name" {
  description = "Name of the NVA VM"
  type        = string
  default     = "fk-nva-vm"
}

variable "inside_private_ip" {
  description = "Static private IP for the inside NIC"
  type        = string
  default     = "10.20.1.4"
}

variable "outside_private_ip" {
  description = "Static private IP for the outside NIC"
  type        = string
  default     = "10.20.2.4"
}

variable "admin_username" {
  description = "Linux admin username"
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "inside_ssh_source_cidrs" {
  description = "CIDRs allowed to reach SSH on the inside NIC"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "outside_ssh_source_cidrs" {
  description = "CIDRs allowed to reach SSH on the outside NIC"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project = "foggykitchen"
    module  = "terraform-az-fk-compute"
    example = "05_nva_dual_nic_vm"
    env     = "dev"
  }
}
