[cmdletbinding()]
param(
    [string]$serviceName,
    [string]$binaryPath,
    [string]$username,
    [string]$password,
    [string]$displayName,
    [string]$description,
    [string]$startUp,

    [string]$computerName,
    [string]$adminLogin,
    [string]$adminPass
    )
Import-Module .\createServiceTaskFunctions.psm1
$creds = New-Object System.Management.Automation.PSCredential ($adminLogin, $adminPass)

Invoke-Command -Credential $creds `
               -ComputerName $computerName `
               -ScriptBlock ${function:Unistall-Service} `
               -ArgumentList @($serviceName, $binaryPath, $username, $password, $displayName, $description, $startUp)
               
