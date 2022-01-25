# creating azure resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}


# storage account
resource "azurerm_storage_account" "storage_acount" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
  tags                     = var.tags
}


#storage container
resource "azurerm_storage_container" "storage_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_acount.name
  container_access_type = "private"
}


#creating workspace
resource "azurerm_databricks_workspace" "workspace" {
  name                = var.databricks_workspace_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"
  tags                = var.tags
}


#databricks hosts
provider "databricks" {
  host = "https://${azurerm_databricks_workspace.workspace.workspace_url}/"
}


locals {
  tenant_id    = "302c59ef-795c-4952-b4e0-6d874f2d4edc"
  client_id    = "55555555-6666-7777-8888-999999999999"
  secret_scope = "some-kv"
  secret_key   = "some-sp-secret"
  container    = "test"
  storage_acc  = "lrs"
}

resource "databricks_mount" "this" {
  name = "tf-abfss"

  uri = "abfss://${local.container}@${local.storage_acc}.dfs.core.windows.net"
  extra_configs = {
    "fs.azure.account.auth.type" : "OAuth",
    "fs.azure.account.oauth.provider.type" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
    "fs.azure.account.oauth2.client.id" : local.client_id,
    "fs.azure.account.oauth2.client.secret" : "{{secrets/${local.secret_scope}/${local.secret_key}}}",
    "fs.azure.account.oauth2.client.endpoint" : "https://login.microsoftonline.com/${local.tenant_id}/oauth2/token",
    "fs.azure.createRemoteFileSystemDuringInitialization" : "false",
  }
}