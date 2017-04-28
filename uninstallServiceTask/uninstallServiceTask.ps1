[cmdletbinding()]
param(
    [string]$serviceName,

    [string]$computerName,
    [string]$adminLogin,
    [string]$adminPass
    )
Import-Module .\uninstallServiceTaskFunctions.psm1
$creds = New-Object System.Management.Automation.PSCredential ($adminLogin, $adminPass)

Invoke-Command -Credential $creds `
               -ComputerName $computerName `
               -ScriptBlock ${function:Uninstall-Service} `
               -ArgumentList @($serviceName)
