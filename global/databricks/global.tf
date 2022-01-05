terraform {

  backend "azurerm" {
    resource_group_name  = "rg_infra"
    storage_account_name = "azstatestore"
    container_name       = "state-container"
    key                  = "db.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.4.0"
    }
  }
}

provider "azurerm" {
/*   subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID */
  features {}
}


# using resource 


#data "terraform_remote_state" "foo" {
# backend = "azurerm"
#config = {
# storage_account_name = "terraform123abc"
#container_name       = "terraform-state"
#key                  = "prod.terraform.tfstate"
#}
#}