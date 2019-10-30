$resourcegroupname = 'rg1'
$vmname = 'instance-1'
$location = 'WestUS'
$networkname = 'network-1'
$subnetname = 'network-1-subnet-1'
$nsgname = 'nsg-instance-1'
$publicip = 'instance-1-public-ip'
$creds = New-Object System.Management.Automation.PSCredential ("arora", ("76492d1116743f0423413b16050a5345MgB8AEsAdwBkAHAARwBsADgAeQAwADkASQBrAEEAegBlAEEAZABDADcAMwBBAFEAPQA9AHwAZgBhAGUANwBhADYAMABiADcAZABmADMAYQBjADQAYQBiAGUANABjADAANAA3AGMANwBiADcAZQAwADkAMABiADcAYQAzADYAZQBiADQAZQA1ADQAOABiADkAOQA4AGIAMwBhADkAMwA1ADMAMABjAGYAZQBhADQAMwA2ADgAZQA0AGQANQA1AGIAYQBiADcAMQA3ADEAYwAyADgAZABhADMAMAAyAGUANwAxADgANAAyAGEAZgA0ADgANQA5ADUA" | ConvertTo-SecureString -Key $key))
$size = 'Standard_D1'
$imagename = 'Win2016Datacenter'
New-AzVM -ResourceGroupName $resourcegroupname -Name $vmname -Size $size -Image $imagename -VirtualNetworkName $networkname -SubnetName $subnetname -SecurityGroupName $nsgname -PublicIpAddressName $publicip -Credential $creds