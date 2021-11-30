resource "azurerm_public_ip" "jen-ip" {
    name                = "jen-ip"
    resource_group_name = azurerm_resource_group.kangtk-rg.name
    location            = azurerm_resource_group.kangtk-rg.location
    allocation_method   = "Static"
  }# public ip create

resource "azurerm_network_interface" "kangtk-NI" {
  name                = "jen-nic"
  location            = azurerm_resource_group.kangtk-rg.location
  resource_group_name = azurerm_resource_group.kangtk-rg.name

  ip_configuration {
    name                          = "jen-ip"
    subnet_id                     = azurerm_subnet.jen-sub.id # subnet select
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.jen-ip.id
    #public ip insert
  }
}#network interface
