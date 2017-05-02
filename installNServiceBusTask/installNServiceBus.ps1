[cmdletbinding()]
param(
    [string]$serviceName,
    [string]$username,
    [string]$password,
    [string]$binaryPath,

    [string]$computerName,
    [string]$adminLogin,
    [string]$adminPass
    )
Import-Module .\installNServiceBusFunctions.psm1
$securePassword = ConvertTo-SecureString $adminPass -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($adminLogin, $securePassword)

Invoke-Command -Credential $creds `
               -ComputerName $computerName `
               -ScriptBlock ${function:Install-NServiceBus} `
               -ArgumentList @($serviceName, $username, $password, $binaryPath)
