# this files added the user into the group and create the same databricks user

data "azurerm_resource_group" "this" {
  name =  var.resource_group_name
}

data "azuread_group" "deguest" {
  display_name     = "grp_deinterview" #TODO : configure
  security_enabled = true
}
#TODO : take from state file
data "azuread_user" "example" {
  object_id = "37d6272a-4b47-4852-8627-cb3cf3b4e4b0"
}

resource "azuread_group_member" "example" {
  group_object_id  = data.azuread_group.deguest.id
  member_object_id = data.azuread_user.example.object_id
}

#TODO : take from state file
provider "databricks" {
  host = "https://adb-2291077507431448.8.azuredatabricks.net"
}

#TODO : configured from variable
resource "databricks_user" "me" {
  user_name = "anujsen18@gmail.com"
}
