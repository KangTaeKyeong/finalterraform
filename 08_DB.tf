resource "azurerm_mysql_server" "kangtk-db-server" {
  name                = "kangtk-db-server"
  location            = azurerm_resource_group.kangtk-rg.location
  resource_group_name = azurerm_resource_group.kangtk-rg.name

  administrator_login          = var.db_admin # db admin id
  administrator_login_password = var.db_password # db password

  sku_name   = "GP_Gen5_4" # storage + cpu  
  /*
  B_Gen4_1 B_Gen4_2 / B_Gen5_1 B_Gen5_2 
  GP_Gen4_2 GP_Gen4_4 GP_Gen4_8 GP_Gen4_16 GP_Gen4_32 / GP_Gen5_2 GP_Gen5_4 GP_Gen5_8 GP_Gen5_16 GP_Gen5_32 GP_Gen5_64 
  MO_Gen5_2 MO_Gen5_4 MO_Gen5_8 MO_Gen5_16 MO_Gen5_32
  */
  storage_mb = 5120 # 1GB = 1024
  version    = "5.7" #engine major version

  backup_retention_days             = 7 # backup days / 7 ~ 35
  auto_grow_enabled                 = true # storage auto grow
  geo_redundant_backup_enabled      = false # geo backup / not supported for Basic
  infrastructure_encryption_enabled = false # data encryption
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false # ssl
#  ssl_minimal_tls_version_enforced  = "TLS1_2"
}
resource "azurerm_mysql_database" "kangtk-db" {
  name                = "kangtkdb"
  resource_group_name = azurerm_resource_group.kangtk-rg.name
  server_name         = azurerm_mysql_server.kangtk-db-server.name
  charset             = "utf8" # incoding
  collation           = "utf8_unicode_ci"
} # setting DB
resource "azurerm_mysql_firewall_rule" "kangtk-db-fw" {
  name                = "test-fw"
  resource_group_name = azurerm_resource_group.kangtk-rg.name
  server_name         = azurerm_mysql_server.kangtk-db-server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
} /* 
allow ip
single IP --> start ip = end ip
IP range --> start ip ~ end ip
All allow --> 0.0.0.0 255.255.255.255
*/
# resource "azurerm_private_endpoint" "endpoint" {
#   name                = "db-endpoint"
#   location            = azurerm_resource_group.kangtk-rg.location
#   resource_group_name = azurerm_resource_group.kangtk-rg.name
#   subnet_id           = azurerm_subnet.db-sub.id
#   depends_on = [azurerm_mysql_server.kangtk-db-server]

#   private_service_connection {
#     name                           = "private-db"
#     private_connection_resource_id = azurerm_mysql_server.kangtk-db-server.id
#     is_manual_connection           = false
#     subresource_names = ["mysqlServer"] # subresource name
#   }
# }
