New-AzResourceGroupDeployment `
  -Name DeployContainerGroup `
  -ResourceGroupName InsertResourceGroup `
  -TemplateFile containerinstance.bicep `
  -Location australiasoutheast