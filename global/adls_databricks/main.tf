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


#creating cluster
data "databricks_node_type" "smallest" {
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on        = [azurerm_databricks_workspace.workspace] #this is dependent on cluster creating
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name  = var.databricks_cluster_name
  spark_version = data.databricks_spark_version.latest_lts.id
  #  spark_version = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 10
  autoscale {
    min_workers = 1
    max_workers = 20
  }
}

#  spark_conf = {
#    "spark.databricks.cluster.profile" : "serverless",
#    "spark.databricks.repl.allowedLanguages" : "python,sql",
#    "spark.databricks.passthrough.enabled" : "true",
#    "spark.databricks.pyspark.enableProcessIsolation" : "true"
#  }

#}
