

data "azurerm_resource_group" "rg" {
  name = "rg_infra"
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



/* provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.this.id
}


resource "databricks_secret_scope" "this" {
  name                     = "application"
  initial_manage_principal = "users"
}

resource "databricks_secret" "this" {
  key          = "service_principal_key"
  string_value =  var.ARM_CLIENT_ID
  scope        = databricks_secret_scope.this.name
}




resource "databricks_azure_adls_gen2_mount" "this" {
  storage_account_name   = data.azurerm_storage_account.this.name
  container_name         = data.azurerm_storage_container.this.name
  mount_name             = "data"
  tenant_id              = data.azurerm_client_config.current.tenant_id
  client_id              = data.azurerm_client_config.current.client_id
  client_secret_scope    = databricks_secret_scope.this.name
  client_secret_key      = databricks_secret.this.key
  initialize_file_system = true
}
 */