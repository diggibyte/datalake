terraform {

  backend "azurerm" {
    resource_group_name  = "rg_infra"
    storage_account_name = "azstatestore"
    container_name       = "state-container"
    key                  = "guser.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.16.0"
    }
    
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}