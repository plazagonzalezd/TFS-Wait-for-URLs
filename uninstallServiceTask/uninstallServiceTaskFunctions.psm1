function Uninstall-Service
{
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$serviceName
        )

        $service = Get-WmiObject -class Win32_Service -Filter "Name='$servicename'"
        if($service -ne $null){
            Write-Host "Unistalling service ''$servicename'..."
            $service.delete()
            Write-Host "'$servicename' was sucessfully uninstalled"
        }
        else{
          Write-Host "Service '$servicename' was not found. Script will continue..."
        }
}
