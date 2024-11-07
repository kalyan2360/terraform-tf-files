

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.7.0"
    }
  }
}

provider "azurerm" {

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret

  features {} # Configuration options
}

terraform {
  cloud {

    organization = "b9kalyan"

    workspaces {
      name = "ACRDEMO"
    }
  }
}
