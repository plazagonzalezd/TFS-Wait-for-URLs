function Uninstall-NServiceBus
{
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$serviceName,
        [Parameter(Position=1, Mandatory=$true)]
        [string]$binaryPath
        )

        $service = Get-WmiObject -class Win32_Service -Filter "Name='$servicename'"

        if($service -ne $null){ #verify the service doesn't exist
            Write-Host "Uninstalling $serviceName..."
            & "$binaryPath\NServiceBus.Host.exe" /uninstall /serviceName:$serviceName
        }
        else{
            Write-Host "Unable to uninstall $serviceName because service was not found"
        }
}
