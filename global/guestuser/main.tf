# Configure the Azure provider
# Azure Provider source and version being used

locals{
  candidate_list = csvdecode(file("./resource/candidate.csv"))
}
data "azurerm_resource_group" "this" {
  name =  var.resource_group_name
}

data "terraform_remote_state" "this"{
  backend = "azurerm"
  config = {
    resource_group_name  = "rg_infra"
    storage_account_name = "azstatestore"
    container_name       = "state-container"
    key                  = "dbw.terraform.tfstate"
  }
}



resource "azuread_invitation" "example" {
  #for_each =  { for inst in local.candidate_list : inst.emailid => inst }
  user_display_name  = "william"
  user_email_address = "rspwilliam@gmail.com"
  redirect_url       = "https://${data.terraform_remote_state.this.outputs.databricks_host}"

  message {
    additional_recipients = ["anuj.sen@diggibyte.com"]
    body                  =  "Hi,\nWe appreciate your interest towards Diggibyte.\nAs a first step for technical evaluation please create your account for online practical test.\nPlease complete the instruction\n1. Click on Accept Invitation\n2."
  }
}



data "azuread_group" "deguest" {
  display_name     = "grp_deinterview" #TODO : configure
  security_enabled = true
}
#TODO : take from state file
data "azuread_user" "users" {
  #for_each =  { for inst in local.candidate_list : inst.emailid => inst }
  user_principal_name = "rspwilliam_gmail.com#EXT#@diggibyte.onmicrosoft.com"#anujsen18_gmail.com#EXT#@diggibyte.onmicrosoft.com
  depends_on=[
    azuread_invitation.example,
  ]
}

resource "azuread_group_member" "example" {
  #for_each =  { for inst in data.azuread_user.users : inst.mail_nickname => inst }
  group_object_id  = data.azuread_group.deguest.id
  member_object_id = data.azuread_user.users.object_id
  depends_on=[
    azuread_invitation.example,
  ]
}

#TODO : take from state file
provider "databricks" {
  host = "https://${data.terraform_remote_state.this.outputs.databricks_host}"
}

#TODO : configured from variable
resource "databricks_user" "dbusers" {
  #for_each =  { for inst in local.candidate_list : inst.emailid => inst }
  user_name =  "rspwilliam@gmail.com"

  depends_on=[
    azuread_invitation.example,
  ]
}



