resource "azurerm_log_analytics_workspace" "law" {
  name                = "kangtklogWorkspace"
  location            = azurerm_resource_group.kangtk-rg.location
  resource_group_name = azurerm_resource_group.kangtk-rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}