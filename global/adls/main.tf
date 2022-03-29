# Configure the Azure provider
# Azure Provider source and version being used

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_resource_group" "this" {
  name =  var.resource_group_name
  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_storage_account" "this" {
  name                      = "st${var.prefix}${var.storage_account_name}"
  location                  = data.azurerm_resource_group.this.location
  resource_group_name       = data.azurerm_resource_group.this.name
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS" # GRS for production use 
  is_hns_enabled            = true  # for hirarical access 
  access_tier               = "Hot"
  enable_https_traffic_only = true

  tags = {
    environment = var.env,
    costcenter= "internal",
    subcostcenter= "de"
  }
}

resource "azurerm_storage_container" "dlcontainer" {
  name                  = "cont${var.prefix}${var.storage_container}"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

data "azuread_service_principal" "spblob" {
  display_name = var.sp_displayname
}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.spblob.object_id

}

