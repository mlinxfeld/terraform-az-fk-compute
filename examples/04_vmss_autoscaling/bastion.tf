resource "azurerm_bastion_host" "foggykitchen_bastion" {
  name                = "foggykitchen_bastion"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  sku                 = "Standard" 
  tunneling_enabled   = true
  ip_connect_enabled  = true

  ip_configuration {
    name                 = "foggykitchen_bastion_ip"
    subnet_id            = module.vnet.subnet_ids["AzureBastionSubnet"]
    public_ip_address_id = azurerm_public_ip.foggykitchen_bastion_public_ip.id
  }

}

resource "azurerm_public_ip" "foggykitchen_bastion_public_ip" {
  name                = "foggykitchen_bastion_public_ip"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}