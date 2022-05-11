<#
New-AzResourceGroupDeployment `
  -Name DeployContainerGroup `
  -ResourceGroupName InsertResourceGroup `
  -TemplateFile containerinstance.bicep `
  -Location australiasoutheast
#>
<#
az acr login --name meltaier --expose-token
az bicep upgrade
az deployment group create --template-file containerinstance.bicep --resource-group InsertResourceGroup

<#>


$ACR_NAME="meltaier"
$SERVICE_PRINCIPAL_NAME="SP-CD-PIPELINE"
$ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query "id" --output tsv)
echo $ACR_REGISTRY_ID


$USER_NAME=az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[].appId" --output tsv
$PASSWORD=az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $ACR_REGISTRY_ID --role acrpull --query "password" --output tsv
echo $PASSWORD
<#
az role assignment create --assignee $SERVICE_PRINCIPAL_ID --scope $ACR_REGISTRY_ID --role acrpull

az container create `
    --resource-group InsertResourceGroup `
    --name mycontainer `
    --image meltaier.azurecr.io/meltaiertestapp:21 `
    --registry-login-server meltaier.azurecr.io `
    --registry-username $USER_NAME `
    --registry-password $PASSWORD
    


#az deployment group create --resource-group insertresourcegroup --template-file containerinstance.bicep
#>