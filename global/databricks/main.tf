

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


resource "azurerm_databricks_workspace" "this" {
  name                = "dbw_${var.prefix}_datalake"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "standard"

  tags = {
    Environment = var.env
  }
}

data "azurerm_storage_account" "this" {
  name                = "st${var.prefix}${var.storage_account_name}"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_storage_container" "this" {
  name                 = "cont${var.prefix}${var.storage_container}"
  storage_account_name = data.azurerm_storage_account.this.name
}

data "azurerm_client_config" "current" {}
