# terraform-az-fk-compute

This repository contains a reusable **Terraform / OpenTofu module** and progressive examples for deploying **Azure Compute resources** — starting from a single Virtual Machine and evolving toward scalable, load-balanced architectures.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed as a **clean, composable compute layer** that builds on top of an existing Azure networking foundation (VNet, subnets).

---

## 🎯 Purpose

The goal of this module is to provide a **clear, educational, and architecture-aware reference implementation** for Azure compute:

- Focused on **Virtual Machines and Virtual Machine Scale Sets**
- Explicit inputs and outputs — no hidden dependencies
- Designed to integrate cleanly with:
  - Azure VNets
  - Load Balancers
  - NSGs
  - Autoscaling scenarios

This is **not** a full landing zone or opinionated platform module.  
It is a **learning-first, building-block module**.

---

## ✨ What the module does

Depending on configuration and example used, the module can create:

- Linux Virtual Machines (single or multiple)
- Virtual Machine Scale Sets (VMSS)
- Network Interfaces (NICs)
- OS Disks and basic VM configuration
- Optional integration with:
  - Azure Load Balancer backend pools
  - Autoscaling (VMSS)

The module intentionally does **not** create:
- Virtual Networks or subnets
- Network Security Groups
- Load Balancers or LB rules
- NAT Gateway
- Bastion
- Monitoring or backup resources

Each of those concerns belongs in its **own dedicated module**.

---

## 📂 Repository Structure

```bash
terraform-az-fk-compute/
├── examples/
│   ├── 01_single_vm/
│   ├── 02_single_vm_with_nsg/        
│   ├── 03_multiple_vms_with_lb/      
│   ├── 04_vmss_autoscaling/         
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

---

## 🚀 Example Usage

```hcl
module "compute" {
  source = "git::https://github.com/mlinxfeld/terraform-az-fk-compute.git?ref=v0.1.0"

  name                = "fk-vm-01"
  location            = "westeurope"
  resource_group_name = "fk-rg"

  subnet_id = module.vnet.subnet_ids["public"]

  vm_size = "Standard_B1s"

  admin_username = "azureuser"
  ssh_public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    project = "foggykitchen"
    env     = "dev"
  }
}
```

---

## 📤 Outputs

| Output | Description |
|------|-------------|
| `deployment_mode` | Selected deployment mode (`vm` or `vmss`) |
| `vm_id` | VM resource ID |
| `vm_private_ip` | Private IP address of the VM |
| `backend_nic_ids` | NIC IDs usable as LB backend targets |
| `vmss_id` | VM Scale Set ID (if used) |
| `autoscale_setting_id` | Autoscale setting ID (if enabled) |
| `attached_backend_pool_ids` | Backend pool IDs this compute instance is attached to |

---

## 🧠 Design Philosophy

- Compute is **stateless infrastructure**, not configuration management
- Networking decisions happen **before** compute
- Load balancing and security are **explicit integrations**
- Outputs are first-class citizens

---

## 🧩 Related Modules & Training

- [terraform-az-fk-vnet](https://github.com/mlinxfeld/terraform-az-fk-vnet)
- [terraform-az-fk-nsg](https://github.com/mlinxfeld/terraform-az-fk-nsg)
- [terraform-az-fk-loadbalancer](https://github.com/mlinxfeld/terraform-az-fk-loadbalancer)
- [terraform-az-fk-disk](https://github.com/mlinxfeld/terraform-az-fk-disk)
- [terraform-az-fk-storage](https://github.com/mlinxfeld/terraform-az-fk-storage)
- [terraform-az-fk-aks](https://github.com/mlinxfeld/terraform-az-fk-aks)

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for details.

---

© 2026 FoggyKitchen.com — *Cloud. Code. Clarity.*
