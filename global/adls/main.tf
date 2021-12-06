# Configure the Azure provider
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
 name     =  var.rgname
  location = var.location
}

resource "azurerm_storage_account" "dlstorage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # GRS for production use 

  tags = {
    environment = var.env
  }
}

  resource "azurerm_storage_container" "dlcontainer" {
  name                  = var.storage_container
  storage_account_name  = azurerm_storage_account.statestore.name
  container_access_type = "private"
}
