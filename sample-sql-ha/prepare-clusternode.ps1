 param (
    [string]$dnsIP
)
Set-ExecutionPolicy Bypass -Scope Process -Force
#Get All the adapters that are on the Server
$adapters = gwmi -cl win32_networkadapterconfiguration | Where-Object {($_.ipaddress) -and $_.dhcpEnabled -eq 'True' } 
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
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False 
Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools
Set-Service SQLSERVERAGENT -StartupType Automatic
Get-Service -Name SQLSERVERAGENT | Start-Service
Set-Service MSSQLServerOLAPService -StartupType Disabled
Set-Service SSASTELEMETRY -StartupType Disabled
Set-Service SQLTELEMETRY -StartupType Disabled
Set-Service SSISTELEMETRY150 -StartupType Disabled
Restart-Computer