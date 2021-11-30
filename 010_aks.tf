resource "azurerm_user_assigned_identity" "identity" {
    resource_group_name = azurerm_resource_group.kangtk-rg.name
    location            = azurerm_resource_group.kangtk-rg.location
    name = "identity1"
}

resource "azurerm_kubernetes_cluster" "kangtk-aks" {
  name                = "kangtk-aks"
  location            = azurerm_resource_group.kangtk-rg.location
  resource_group_name = azurerm_resource_group.kangtk-rg.name
  dns_prefix          = "example-aks1"

  linux_profile {
    admin_username = var.ssh_name

    ssh_key {
      key_data = file(var.ssh_path)
    }
  }

  default_node_pool {
    name       = "node"
    # node_count = 2 # node number
    vm_size    = "Standard_D3_v2"
    type       = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    max_count = "10" # autoscaling max nodes
    min_count = "2" # autoscaling min nodes
    vnet_subnet_id = azurerm_subnet.aks-sub.id # azure CNI subnet
    max_pods = 30
  } # setting nodepool

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin = "azure" # CNI
    network_policy = "calico"
    service_cidr = "10.0.0.0/27"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip = "10.0.0.2"
  }

  role_based_access_control {
    enabled = false
  }

  addon_profile {
    http_application_routing {
      enabled = false
    }

    ingress_application_gateway {
      enabled = true
      gateway_id = azurerm_application_gateway.agw.id
    } # agw attach

    oms_agent {
      enabled = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
    } # monitor
  } 

  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  } # Cluster ID

  depends_on = [azurerm_log_analytics_workspace.law, azurerm_virtual_network.kangtk-vnet, azurerm_application_gateway.agw]
}

resource "azurerm_role_assignment" "ra1" {
    scope                = azurerm_subnet.agw-sub.id
    role_definition_name = "Network Contributor"
    principal_id         = var.aks_service_principal_object_id 
    depends_on = [azurerm_virtual_network.kangtk-vnet]
}

resource "azurerm_role_assignment" "ra2" {
    scope                = azurerm_user_assigned_identity.identity.id
    role_definition_name = "Managed Identity Operator"
    principal_id         = var.aks_service_principal_object_id
    depends_on           = [azurerm_user_assigned_identity.identity]
}

resource "azurerm_role_assignment" "ra3" {
    scope                = azurerm_application_gateway.agw.id
    role_definition_name = "Contributor"
    principal_id         = azurerm_user_assigned_identity.identity.principal_id
    depends_on           = [azurerm_user_assigned_identity.identity, azurerm_application_gateway.agw]
}

resource "azurerm_role_assignment" "ra4" {
    scope                = azurerm_resource_group.kangtk-rg.id
    role_definition_name = "Reader"
    principal_id         = azurerm_user_assigned_identity.identity.principal_id
    depends_on           = [azurerm_user_assigned_identity.identity, azurerm_application_gateway.agw]
}