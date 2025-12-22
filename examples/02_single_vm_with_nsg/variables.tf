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
  description = "VNet name"
  type        = string
  default     = "fk-vnet-with-subnets"
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "fk-public-vm"
}

variable "admin_username" {
  description = "Linux admin username"
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "vnet_address_space" {
  description = "VNet CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnets" {
  description = "Subnet map used by terraform-az-fk-vnet"
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
    delegations       = optional(list(any), [])
  }))

  default = {
    fk-subnet-public = {
      address_prefixes = ["10.10.0.0/24"]
    }
    fk-subnet-private = {
      address_prefixes = ["10.10.1.0/24"]
    }
  }
}

variable "ssh_source_cidrs" {
  description = "CIDR blocks allowed to SSH to the VM (via the subnet NSG). For demos you can use 0.0.0.0/0, but it's not recommended for real environments."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_http" {
  description = "Enable inbound HTTP(80) in the NSG for simple web demos"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project = "foggykitchen"
    module  = "terraform-az-fk-compute"
    example = "02_single_vm_with_nsg"
    env     = "dev"
  }
}
