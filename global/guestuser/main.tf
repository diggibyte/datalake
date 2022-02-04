# Configure the Azure provider
# Azure Provider source and version being used
data "azurerm_resource_group" "this" {
  name =  var.resource_group_name
}



resource "azuread_invitation" "example" {
  user_display_name  = "Anujsen18"
  user_email_address = "anujsen18@gmail.com"
  redirect_url       = "https://portal.azure.com"

  message {
    additional_recipients = ["anuj.sen@diggibyte.com"]
    body                  =  " Hello there! \n You are invited to join  Diggibyte  Data engineer Team !\n Plese complete the instruction "
  }
}