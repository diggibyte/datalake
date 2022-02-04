# login to az account with microsoft account 
# az login 
# az account set --subscription="SUBSCRIPTION_ID"
subs="xx-xxx-xx-xx" 
name="sp_invite_user"
resourcegroup="rg_infra"
az account set --subscription=${subs}
az ad sp create-for-rbac -n ${name}  --role="Contributor" --scopes="/subscriptions/${subs}"
#az ad sp create-for-rbac -n ${name} --role Contributor --scopes /subscriptions/${subs}/resourceGroups/${resourcegroup} 

