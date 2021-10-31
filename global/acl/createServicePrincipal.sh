# login to az account with microsoft account 
# az login 
# az account set --subscription="SUBSCRIPTION_ID"
subs="xxxxxxxx-xxxxxx-xxxxx-xxxx" 
az account set --subscription=${subs}
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${subs}"
# 

