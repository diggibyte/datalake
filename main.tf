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
  name     = var.rgname
  location = var.location
}
