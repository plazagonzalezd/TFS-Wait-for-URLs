[cmdletbinding()]
param(
    [string]$serviceName,

    [string]$computerName,
    [string]$adminLogin,
    [string]$adminPass
    )
Import-Module .\uninstallServiceTaskFunctions.psm1
$securePassword = ConvertTo-SecureString $adminPass -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($adminLogin, $securePassword)

Invoke-Command -Credential $creds `
               -ComputerName $computerName `
               -ScriptBlock ${function:Uninstall-Service} `
               -ArgumentList @($serviceName)
