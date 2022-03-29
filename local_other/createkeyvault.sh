az login

keyvaultName="kvinfra001"
az keyvault secret set --vault-name $keyvaultName --name "infra-client-id" --value "3fdbc1f4-4f96-456e-aba5-67f80f651936"
az keyvault secret set --vault-name $keyvaultName --name "infra-tenant-id" --value "d074e917-c8d9-42cc-8986-2cd1bdfbd079"
az keyvault secret set --vault-name $keyvaultName --name "infra-subscription-id" --value "03b49938-94b4-494b-bcd0-6d616cb5955d"
az keyvault secret set --vault-name $keyvaultName --name "infra-client-secret" --value "1.oV~2sXzSVvZ9JGPzt6zJl0m~wJAPaS-0"
