
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

variable "sp_displayname" {
  type        = string
  description = "Name of service principal to assign access "

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