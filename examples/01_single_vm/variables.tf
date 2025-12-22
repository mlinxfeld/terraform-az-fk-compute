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
  type    = string
  default = "fk-vnet-with-subnets"
}

variable "vm_name" {
  type    = string
  default = "fk-public-vm"
}

variable "vnet_address_space" {
  description = "VNet CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnets" {
  description = "Purpose-driven subnets"
  type = map(object({
    address_prefixes = list(string)
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

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project = "foggykitchen"
    module  = "terraform-az-fk-compute"
    example = "01_single_vm"
    env     = "dev"
  }
}

