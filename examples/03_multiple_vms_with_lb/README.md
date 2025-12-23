# Example 03: Multiple Virtual Machines behind Azure Load Balancer

This example demonstrates a **real-world Azure compute topology** where multiple
Linux Virtual Machines are deployed into a **private subnet** and exposed publicly
**only through an Azure Load Balancer**.

Administrative access to the VMs is provided via **Azure Bastion**, while outbound
internet access is handled by a **NAT Gateway**.

This example builds on previous networking foundations and introduces the first
**production-style traffic flow**.

---

## 🧭 Architecture Overview

<img src="03_multiple_vms_with_lb_architecture.png" width="900"/>

**Figure 1.** Multiple backend VMs deployed in a private subnet, exposed via Azure Load Balancer, with secure access through Bastion and controlled outbound traffic via NAT Gateway.

---

## 🏗️ Architecture Description

This deployment assumes that a Virtual Network already exists
(e.g. created using the `terraform-az-fk-vnet` module).

The architecture consists of:

- A single **Azure Virtual Network**
- Three dedicated subnets:
  - `AzureBastionSubnet` (for Bastion)
  - `fk-subnet-private` (for backend VMs)
- An **Azure Load Balancer** with a public frontend IP
- Multiple **Linux Virtual Machines** deployed in the private subnet
- A **Network Security Group** attached at the subnet level
- An **Azure Bastion Host** for secure SSH access
- A **NAT Gateway** providing controlled outbound internet access

---

## 🔀 Traffic Flow

### Inbound traffic (HTTP)

Internet → Public Load Balancer (TCP/80) → Backend Pool → Private VMs running NGINX

### Administrative access (SSH)

Operator → Azure Bastion → Private VM (SSH over private IP)

### Outbound traffic

Private VM → NAT Gateway → Internet

---

## 🧱 Security Model

- No public IPs on backend VMs
- NSG applied at the subnet level
- SSH allowed only from AzureBastionSubnet
- HTTP allowed only from Load Balancer
- Default deny for all other inbound traffic

---

## ⚙️ Compute Configuration

Each backend VM:
- Is deployed using the `terraform-az-fk-compute` module
- Uses cloud-init to install and configure **NGINX**
- Is registered in the Load Balancer backend pool
- Serves a demo HTML page identifying the VM hostname

---

## 🖼️ Azure Portal View

After deployment, you should see:

1. Load Balancer health probes reporting all backends as healthy

<img src="03_multiple_vms_with_lb_rule_health_status.png" width="900"/>

2. Backend VMs without public IPs

<img src="03_multiple_vms_with_lb_vm_no_public_ips.png" width="900"/>

3. LoadBalancer Frontend IP

<img src="03_multiple_vms_with_lb_frontent_ip.png" width="900"/>

Accessing the Load Balancer public IP should display the NGINX demo page.

<img src="03_multiple_vms_with_lb_web_browser_lb_check.png" width="900"/>

---

## 🚀 Deployment Steps

```bash
tofu init
tofu plan
tofu apply
```

---

## 🧹 Cleanup

```bash
tofu destroy
```

---

## ✅ Summary

This example demonstrates:
- Multiple private VMs behind a Load Balancer
- Secure administrative access via Bastion
- Controlled outbound connectivity using NAT Gateway
- A production-style Azure compute topology

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](../../LICENSE) for details.

© 2025 FoggyKitchen.com — *Cloud. Code. Clarity.*
