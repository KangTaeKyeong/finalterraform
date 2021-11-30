resource "azurerm_subnet" "aks-sub" {
  name                 = "aks-sub" # ex) pub_0
  resource_group_name  = azurerm_resource_group.kangtk-rg.name
  virtual_network_name = azurerm_virtual_network.kangtk-vnet.name
  address_prefixes     = ["10.0.0.128/25"]
}# pri
resource "azurerm_subnet" "agw-sub" {
  name                 = "agw-sub" # ex) pub_0
  resource_group_name  = azurerm_resource_group.kangtk-rg.name
  virtual_network_name = azurerm_virtual_network.kangtk-vnet.name
  address_prefixes     = ["10.0.0.32/29"]
}# pub
resource "azurerm_subnet" "db-sub" {
  name                 = "db-sub" # ex) pri_0
  resource_group_name  = azurerm_resource_group.kangtk-rg.name
  virtual_network_name = azurerm_virtual_network.kangtk-vnet.name
  address_prefixes     = ["10.0.0.40/29"]
  enforce_private_link_endpoint_network_policies = true
}# pri
resource "azurerm_subnet" "jen-sub" {
  name                 = "jen-sub" # ex) pub_0
  resource_group_name  = azurerm_resource_group.kangtk-rg.name
  virtual_network_name = azurerm_virtual_network.kangtk-vnet.name
  address_prefixes     = ["10.0.0.48/29"]
}# pub

