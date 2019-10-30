$resourcegroupname = 'rg1'
$location = 'WestUS'
New-AzResourceGroup -Name $resourcegroupname -Location $location
#Get-AzResourceGroup