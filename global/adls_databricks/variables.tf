variable "resource_group_name" {
  type        = string
  description = "Resource group name in Azure"
  default     = "terraform"
}

variable "resource_group_location" {
  type        = string
  description = "resource group Location name in Azure"
  default     = "south india"
}

variable "storage_account_name" {
  type        = string
  description = "Data lake storage account name"
  default     = "dbstorage"
}

variable "storage_container_name" {
  type        = string
  description = "Data lake container name"
  default     = "dbcontainer"
}

#Databricks related variables
variable "databricks_workspace_name" {
  type        = string
  description = "Databricks workspace name"
  default     = "dbworkspace"
}

variable "databricks_cluster_name" {
  type        = string
  description = "Databricks cluster name "
  default     = "terraform_cluster"
}

variable "tags" {
  default = {
    terraform = "datalake_mounting"
  }
}

/*
variable "mount_name" {
  type        = string
  description = "databricks mount directory name"
  default     = "data"
}

#secret related variables
variable "client_secret_name" {
  type        = string
  description = "Client secret name"
}

variable "client_secret" {
  type        = string
  description = "Client secret"
}
*/
