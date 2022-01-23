# Configure the Azure provider
# Azure Provider source and version being used
terraform {
  
 # backend "azurerm"{}

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

resource "azurerm_resource_group" "infra" {
  name     = var.resource_group_name
  location = var.location
}
