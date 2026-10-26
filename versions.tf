terraform {
  required_version = ">= 1.9.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "msaidiRG"
    storage_account_name = "stmsaiditfstate"
    container_name       = "tfstate"
    key                  = "tp-gitops.tfstate"
    use_azuread_auth     = true
  }
}
