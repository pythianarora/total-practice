 param (
    [string]$dnsIP
)
Set-ExecutionPolicy Bypass -Scope Process -Force
#Get All the adapters that are on the Server
$adapters = gwmi -cl win32_networkadapterconfiguration | ? {($_.ipaddress) -and $_.dhcpEnabled -eq 'True' } 
foreach ($adapter in $adapters) {
    # Get original settings
    $ipAddress = $adapter.IPAddress[0]
    $subnetMask = $adapter.IPSubnet[0]
    $dnsServers = $dnsIP
    $defaultGateway = $adapter.DefaultIPGateway
 
    # Set to static and set dns and gateway:
    $adapter.EnableStatic($ipAddress,$subnetMask)
    $adapter.SetDNSServerSearchOrder($dnsServers)
    $adapter.SetGateways($defaultGateway)
} 
Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools;