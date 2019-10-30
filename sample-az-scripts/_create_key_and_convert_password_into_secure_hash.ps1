<# -- Create a Key File to be used
$Key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$key | Out-File C:\client-work\Azure\securepass.key
#>

#alternate key
#$key = (([System.DirectoryServices.ActiveDirectory.Domain]::getcurrentdomain().GetDirectoryEntry().objectSid)[0])

#convert password into secure hash
#"Y0urP@ssw0rd!" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString -Key (get-content C:\client-work\Azure\securepass.key.key)

#verify the username and password with the key
$key = get-content C:\client-work\Azure\securepass.key.key
$creds = New-Object System.Management.Automation.PSCredential("arora@pythian.com", ("76492d1116743f0423413b16050a5345MgB8AEsAdwBkAHAARwBsADgAeQAwADkASQBrAEEAegBlAEEAZABDADcAMwBBAFEAPQA9AHwAZgBhAGUANwBhADYAMABiADcAZABmADMAYQBjADQAYQBiAGUANABjADAANAA3AGMANwBiADcAZQAwADkAMABiADcAYQAzADYAZQBiADQAZQA1ADQAOABiADkAOQA4AGIAMwBhADkAMwA1ADMAMABjAGYAZQBhADQAMwA2ADgAZQA0AGQANQA1AGIAYQBiADcAMQA3ADEAYwAyADgAZABhADMAMAAyAGUANwAxADgANAAyAGEAZgA0ADgANQA5ADUA" | ConvertTo-SecureString -Key $key))
$user = $creds.GetNetworkCredential().UserName
$pass = $creds.GetNetworkCredential().Password
$user
$pass 