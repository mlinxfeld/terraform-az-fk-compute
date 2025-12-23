# Azure Compute with Terraform/OpenTofu – Training Examples

This directory contains all progressive examples used with the **terraform-az-fk-compute** module.
The examples are designed as **incremental building blocks**, starting from a single Azure Virtual Machine and gradually evolving toward scalable, load-balanced compute architectures.

These examples are part of the **FoggyKitchen.com** training ecosystem and are used across Azure
and multicloud courses (Azure Fundamentals, AKS, and advanced networking scenarios).

---

## 🧭 Example Overview

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **Single Virtual Machine** | Minimal Linux VM, NIC attachment, compute basics |
| 02 | **Single VM with NSG** | Network Security Groups and inbound/outbound control |
| 03 | **Multiple VMs with Load Balancer** | Azure Load Balancer, backend pools, health probes |
| 04 | **VM Scale Set with Autoscaling** | VMSS, autoscale rules, backend integration *(planned)* |

Each example builds on the **concepts** introduced in the previous one, but can be applied
independently for learning and experimentation.

---

## ⚙️ How to Use

Each example directory contains:
- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A minimal, runnable architecture (no placeholder resources)

To run an example:

```bash
cd examples/01_single_vm
tofu init
tofu plan
tofu apply
```

You can apply examples independently, but the **recommended approach is sequential**:
01 → 02 → 03 → 04

This mirrors real-world compute design, where complexity is introduced only when required.

---

## 🧩 Design Principles

- One example = one architectural goal
- No unused or placeholder resources
- Clear separation of concerns (networking vs compute)
- Compute designed to integrate with other modules (VNet, LB, NSG)

These examples intentionally avoid:
- Full landing zones
- Opinionated enterprise frameworks
- Hidden dependencies between examples

---

## 🧩 Related Resources

- [FoggyKitchen Azure Compute Module (terraform-az-fk-compute)](../)
- [FoggyKitchen Azure VNet Module (terraform-az-fk-vnet)](https://github.com/mlinxfeld/terraform-az-fk-vnet)
- [FoggyKitchen AKS Module (terraform-az-fk-aks)](https://github.com/mlinxfeld/terraform-az-fk-aks)
- [OCI OKE Module (terraform-oci-fk-oke)](https://github.com/mlinxfeld/terraform-oci-fk-oke)

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](../LICENSE) for details.

---

© 2025 FoggyKitchen.com — *Cloud. Code. Clarity.*

