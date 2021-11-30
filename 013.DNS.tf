# resource "azurerm_dns_zone" "dns-zone" {
#   name                = "kangtkmu.xyz"
#   resource_group_name = azurerm_resource_group.kangtk-rg.name
# }
# resource "azurerm_dns_a_record" "hamstercave" {
#   name                = "@"
#   zone_name           = azurerm_dns_zone.dns-zone.name
#   resource_group_name = azurerm_resource_group.kangtk-rg.name
#   ttl                 = 300
#   records             = ["20.196.225.175"]
# }
# resource "azurerm_dns_txt_record" "txt" {
#   name                = "_acme-challenge"
#   zone_name           = azurerm_dns_zone.dns-zone.name
#   resource_group_name = azurerm_resource_group.kangtk-rg.name
#   ttl                 = 300

#   record {
#     value = "rvyst7OxzuQxcdv5JcUXUsOg52UJMiLKnEyAhaBjS3E"
#   }

#   record {
#     value = "HUE0dS2yskgyRfRV2Fvrw8AImjqLjUzmbAk5omFxk8Y"
#   } # SSL
# }