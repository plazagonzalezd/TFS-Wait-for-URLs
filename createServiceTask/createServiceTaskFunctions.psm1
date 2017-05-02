function Install-Service
{
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$serviceName,
        [Parameter(Position=1, Mandatory=$true)]
        [string]$binaryPath,
        [Parameter(Position=2)]
        [string]$username,
        [Parameter(Position=3)]
        [string]$password,
        [Parameter(Position=4)]
        [string]$displayName,
        [Parameter(Position=5)]
        [string]$description,
        [Parameter(Position=6)]
        [string]$startUp
        )

        $service = Get-WmiObject -class Win32_Service -Filter "Name='$servicename'"

        if($service -eq $null){ #verify the service doesn't exist
            $NSParams = @{
                Name = $serviceName
                BinaryPathName = $binaryPath
            }
            if($username -and $password){
                $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
                $creds = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
                $NSParams.Credential = $creds
            }
            if($description){$NSParams.Description = $description}
            if($displayName){$NSParams.DisplayName = $displayName}
            if($startUp){$NSParams.StartupType = $startUp}

            Write-Host "Creating new service with parameters: "
            $NSParams | Out-String | Write-Host

            New-Service @NSParams
        }
}
