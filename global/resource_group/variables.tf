variable "resource_group_name" {
  type        = string
  description = "Name of Resource Group"

}

variable "env" {
  type        = string
  description = "Name of Enviornment"
  default = "dev"

}

variable "location" {
  type        = string
  description = "locaion  of Resource Group"
  default = "North Europe"
}