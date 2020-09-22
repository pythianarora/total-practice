#functions for formatting and logging
function Write-Status ($message) {Write-Host ("[$(get-date -Format 'HH:mm:ss')] $message.").PadRight(75) -NoNewline -ForegroundColor Yellow }
function Update-Status ($status = "Success") {Write-Host "[$status]" -ForegroundColor Green}
function Exit-Fail ($message) {
	Write-Host "`nERROR: $message" -ForegroundColor Red
	Write-Host "Result:Failed." -ForegroundColor Red
	exit 0x1
}
function NoExit-Fail ($message) {
	Write-Host "`nERROR: $message" -ForegroundColor Red
	Write-Host "Result:Continue." -ForegroundColor Red
}

Add-AzureRmAccount

Import-Module AzureRM

#Replace <<placeholder>> with actual azure details 
$subscription_id = "<<Your Subscription ID>>"
$datafactory_resourcegroup_name = "<<Resource Group Name where Data Factories are hosted>>" #Change the Resource Name if your Data Factories exists in separate RG
$log_analytics_workspace_name = "<<Resource Group Name for OMS>>"
$datafactory_name = "<<Data Factory 1>>", "<<Data Factory 2>>"
$workspace_name = "<<Log Analystics Workspace Name>>"

foreach ($df in $datafactory_name){
    ##Generate the Resource IDs
    $diagnostic_setting_name = "$($df)_logdiagnostics"
    $resource_id = "/subscriptions/$subscription_id/resourceGroups/$datafactory_resourcegroup_name/providers/Microsoft.DataFactory/factories/$df"
    $workspace_id = "/subscriptions/$subscription_id/resourcegroups/$log_analytics_workspace_name/providers/microsoft.operationalinsights/workspaces/$workspace_name"
    try{
        Write-Status "Enabling Log Diagnostics for $df ADF."
        Set-AzureRmDiagnosticSetting -Name $diagnostic_setting_name -ResourceId $resource_id -MetricCategory AllMetrics `
                                     -Categories ActivityRuns, PipelineRuns, TriggerRuns, SSISPackageEventMessages, SSISPackageExecutableStatistics, `
                                     SSISPackageEventMessageContext, SSISPackageExecutionComponentPhases, SSISPackageExecutionDataStatistics, `
                                     SSISIntegrationRuntimeLogs -Enabled $true -WorkspaceId $workspace_id -ErrorAction Stop | Out-Null
        Update-Status
    }
    catch{
        NoExit-Fail $_.Exception.Message
    }
}