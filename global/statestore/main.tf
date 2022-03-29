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


resource "azurerm_storage_account" "statestore" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS" # GRS for production use
  is_hns_enabled            = true  # for hirarical access
  access_tier               = "Hot"
  enable_https_traffic_only = true

  tags = {
    environment = var.env
  }
}
  resource "azurerm_storage_container" "statecontainer" {
  name                  = var.storage_container
  storage_account_name  = azurerm_storage_account.statestore.name
  container_access_type = "private"
}


data "azurerm_storage_account_sas" "storagesas" {
  connection_string = azurerm_storage_account.statestore.primary_connection_string
  https_only        = true
  start  = "2021-10-31"
  expiry = "2022-10-20"
  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }
    resource_types {
    service   = true
    container = true
    object    = true
  }
   permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
  }
}


data "azurerm_storage_account_blob_container_sas" "containersas" {
  connection_string = azurerm_storage_account.statestore.primary_connection_string
  container_name    = azurerm_storage_container.statecontainer.name
  https_only        = true
  start  = "2021-10-31"
  expiry = "2022-10-20"
  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }
  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
}

output "sas_container_query_string" {
  value = data.azurerm_storage_account_blob_container_sas.containersas.sas
   sensitive = true
}
output "sas_storage_query_string" {
  value = data.azurerm_storage_account_sas.storagesas.sas
   sensitive = true
}