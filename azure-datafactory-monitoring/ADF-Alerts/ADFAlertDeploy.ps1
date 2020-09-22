$resource_group_name = "<<Enter the Resource Group Name to create the deployment>>"
$location = "<<Enter Azure Location>>"
$deployment_time = Get-Date -Format yyyyMMddHHmmss
$deployment_name = "adfdeployment" + "-" + $deploymentTime
$template_failedpipeline_file = (Get-Location).Path + "\" + "template.failedpipeline.json"
$template_failedtrigger_file = (Get-Location).Path + "\" + "template.failedtrigger.json"
$template_irhighcpu_file = (Get-Location).Path + "\" + "template.ircpuhigh.json"
$param_file = (Get-Location).Path + "\"  + "parameter.json"
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_failedpipeline_file -TemplateParameterFile $param_file
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_failedtrigger_file -TemplateParameterFile $param_file
New-AzureRmResourceGroupDeployment -Name $deployment_name -ResourceGroupName $resource_group_name -TemplateFile $template_irhighcpu_file -TemplateParameterFile $param_file