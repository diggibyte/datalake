/*variable "SUBSCRIPTION_ID" {
  type        = string
  description = "SUBSCRIPTION_ID for Azure Service principal ."
}

variable "TENANT_ID" {
  type        = string
  description = "SUBSCRIPTION_ID for Azure Service principal ."
}

variable "CLIENT_ID" {
  type        = string
  description = "SUBSCRIPTION_ID for Azure Service principal ."
}
variable "CLIENT_SECRET" {
  type        = string
  description = "SUBSCRIPTION_ID for Azure Service principal ."

}*/

variable "rgname" {
  type        = string
  description = "Name of Resource Group"

}

variable "env" {
  type        = string
  description = "Name of Enviornment"

}

variable "storage_account_name" {
  type        = string
  description = "Name of storage account name"

}

variable "storage_container" {
  type        = string
  description = "Name of storage container name"

}
variable "location" {
  type        = string
  description = "locaion  of Resource Group"
  default = "West Europe"
}