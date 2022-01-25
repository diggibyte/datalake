terraform {

  backend "azurerm" {
    resource_group_name  = "rg_infra"
    storage_account_name = "azstatestore"
    container_name       = "state-container"
    key                  = "dbm.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}



