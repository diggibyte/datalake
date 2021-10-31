Creating Azure Data lake using Terraform

usage for setting up  remote azure state file 
```
terraform init   -backend-config=backend.hcl
terraform plan   -var-file=dev.tfvars
terraform apply  -var-file=dev.tfvars 
```

backend.hcl 
```
#backend.hcl
resource_group_name  = "resource group "
storage_account_name = "azure blob storage"
container_name       = "container on azure blob"
key                  = "file name in container"
sas_token            = "xxxxx-xxx"
```