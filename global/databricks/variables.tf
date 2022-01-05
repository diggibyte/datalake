
variable "rgname" {
  type        = string
  description = "Name of Resource Group"

}

variable "env" {
  type        = string
  description = "Name of Enviornment"

}

variable "workspace_name" {
  type        = string
  description = "Name of Databricks workspace"

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
  default     = "North Europe"
}

variable "prefix" {
  type        = string
  description = "name prefix to identify organization / department"

}