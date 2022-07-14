provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "marksTerraformCluster" {
  name     = "marksTerraformCluster-rg"
  location = "West US3"
}

resource "azurerm_kubernetes_cluster" "marksTerraformCluster" {
  name                = "markterraformcluster-aks1"
  location            = azurerm_resource_group.marksTerraformCluster.location
  resource_group_name = azurerm_resource_group.marksTerraformCluster.name
  dns_prefix          = "marksTerraformClusteraks1"

default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.marksTerraformCluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.marksTerraformCluster.kube_config_raw

  sensitive = true
}
