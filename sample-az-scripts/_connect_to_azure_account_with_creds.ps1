$key = get-content C:\client-work\Azure\securepass.key
$creds = New-Object System.Management.Automation.PSCredential ("arora@pythian.com", ("76492d1116743f0423413b16050a5345MgB8AEsAdwBkAHAARwBsADgAeQAwADkASQBrAEEAegBlAEEAZABDADcAMwBBAFEAPQA9AHwAZgBhAGUANwBhADYAMABiADcAZABmADMAYQBjADQAYQBiAGUANABjADAANAA3AGMANwBiADcAZQAwADkAMABiADcAYQAzADYAZQBiADQAZQA1ADQAOABiADkAOQA4AGIAMwBhADkAMwA1ADMAMABjAGYAZQBhADQAMwA2ADgAZQA0AGQANQA1AGIAYQBiADcAMQA3ADEAYwAyADgAZABhADMAMAAyAGUANwAxADgANAAyAGEAZgA0ADgANQA5ADUA" | ConvertTo-SecureString -Key $key))
$tenantid = "29a10a41-1f81-4762-87a1-4a91742c70e1"
$subscription = "55e0c3fd-3e57-4793-bc95-9b7afe572d8b"
Connect-AzAccount -Credential $creds -Tenant $tenantid -Subscription $subscription
