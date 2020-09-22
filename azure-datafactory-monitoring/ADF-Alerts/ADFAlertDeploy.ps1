$resource_group_name = "azure-datafactory-selfhosted-ir"
$location = "North Europe"
$deployment_time = Get-Date -Format yyyyMMddHHmmss
$deployment_name = "adfdeployment" + "-" + $deploymentTime
$template_file = (Get-Location).Path + "\" + "template.json"
$param_file = (Get-Location).Path + "\"  + "parameter.json"
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_file -TemplateParameterFile $param_file
