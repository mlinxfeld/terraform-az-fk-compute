resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${var.vm_name}-nsg"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.ssh_source_cidrs
    destination_address_prefix = "*"
  }

  # Optional: allow HTTP for simple web demos (disabled by default)
  dynamic "security_rule" {
    for_each = var.enable_http ? [1] : []
    content {
      name                       = "Allow-HTTP"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = var.tags
}

# Attach NSG to the public subnet used by the VM
resource "azurerm_subnet_network_security_group_association" "public_subnet_assoc" {
  subnet_id                 = module.vnet.subnet_ids["fk-subnet-public"]
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}
