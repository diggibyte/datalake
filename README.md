THIS Repository consist of individual resource for creatting Azure resource and managing there access 

- acl :  
this module consist shell script for creating azure service principal using az cli 
- statestore :  
this is terraform code to create remote state store on azure i.e azure adls2 which can we use later 

how to use remote state 
````
terraform {

  backend "azurerm" {
    resource_group_name  = "resource group name for remote adls "
    storage_account_name = "remotetatestore"
    container_name       = "state-container"
    key                  = "prefix.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}
````

other modules 

- adls 
- databricks 
- VM

 


usage  
```
terraform init   -backend-config=backend.hcl
terraform plan   -var-file=dev.tfvars
terraform apply  c 
```


##Adding Guest user in AD  and Databricks :
create guest user 
give permission to workspace 
add user in workspace 