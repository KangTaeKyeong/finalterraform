resource "azurerm_virtual_network" "kangtk-vnet" {
  name                = "kangtk-network"
  resource_group_name = azurerm_resource_group.kangtk-rg.name
  location            = azurerm_resource_group.kangtk-rg.location
  address_space       = ["10.0.0.0/8"]
}# setting vnet