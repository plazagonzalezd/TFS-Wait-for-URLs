function Install-NServiceBus
{
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$serviceName,
        [Parameter(Position=1, Mandatory=$true)]
        [string]$username,
        [Parameter(Position=2, Mandatory=$true)]
        [string]$password,
        [Parameter(Position=3, Mandatory=$true)]
        [string]$binaryPath
        )

        $service = Get-WmiObject -class Win32_Service -Filter "Name='$servicename'"

        if($service -eq $null){ #verify the service doesn't exist
            Write-Host "Creating new service $serviceName..."
            & "$binaryPath\NServiceBus.Host.exe" /install /serviceName:$serviceName /username:$username /password:$password
        }
        else{
            Write-Host "Unable to install $serviceName because service already exists"
        }
}
