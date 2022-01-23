

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


#resource "databricks_secret_scope" "terraform" {
#  name                     = "application"
#  initial_manage_principal = "users"
#}

#resource "databricks_secret" "service_principal_key" {
#  key          = "service_principal_key"
 # string_value = "${var.ARM_CLIENT_SECRET}"
 # scope        = databricks_secret_scope.terraform.name
#}

locals {
  tenant_id    = "d074e917-c8d9-42cc-8986-2cd1bdfbd079"
  client_id    = "febc5c5e-6b8d-44c6-96a1-94830310a2de"
  secret_scope = "sc-sp-dwp"
  secret_key   = "sc-dbw-mount"
  container    = "contpnswe"
  storage_acc  = "stpndatalake"
}

provider "databricks" {
  host                        = azurerm_databricks_workspace.this.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id
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
