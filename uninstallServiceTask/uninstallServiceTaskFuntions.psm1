function Uninstall-Service
{
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$serviceName
        )

        $service = Get-WmiObject -class Win32_Service -Filter "Name='$servicename'"
        if($service -ne $null){
            $service.delete()
        }
}
