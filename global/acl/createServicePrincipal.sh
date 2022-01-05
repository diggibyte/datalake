# login to az account with microsoft account 
# az login 
# az account set --subscription="SUBSCRIPTION_ID"
subs="xxxxxx-xxxx--xxxx-" 
name="sp_rg_infra"
resourcegroup="rg_infra"
az account set --subscription=${subs}
#az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${subs}"
az ad sp create-for-rbac -n ${name} --role Contributor --scopes /subscriptions/${subs}/resourceGroups/${resourcegroup} 

