variable "resource_group_name" {
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