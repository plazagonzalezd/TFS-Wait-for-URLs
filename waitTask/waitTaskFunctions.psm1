<#
.SYNOPSIS
Checks if a list of website are available.

.DESCRIPTION
The Wait-Urls cmdlet waits for a sucessful HTTP response from a list of URLs.

If no response is received after a specified timeout period, a timeout error
will occur.

.EXAMPLE
Wait-Urls -Urls "https://www.google.com/" -Seconds 120

.LINK
https://github.com/plazagonzalezd/TFS-Wait-for-URLs
#>
function Wait-Urls{
  param(
            [Parameter(Mandatory=$true)]
            [string]$Urls,
            [Parameter(Mandatory=$true)]
            [int]$Seconds
        )
    $timeout = New-Timespan -Seconds $Seconds                         #Creates time interval of length $Seconds
    $sw = [diagnostics.stopwatch]::StartNew()                         #Start stop-watch
    $urlList = [System.Collections.ArrayList]($urls -split ",")       #Split list of urls in an array
    Write-Host "Trying to contact the following site(s): ""$urls"""
    while($urlList.Count -ne 0 -and $sw.Elapsed -lt $timeout){        #While there are urls in the list and elapsed time is less than $Seconds
        foreach($url in $urlList){                                    #Iterates over list of urls
            try{
                $HTTP_Request = [System.Net.WebRequest]::Create($url) #Create HTTP_Request
                $HTTP_Response = $HTTP_Request.GetResponse()          #Get response from request. If there's no response from server, error is handle with catch
                $HTTP_Status = [int]$HTTP_Response.StatusCode         #Get response status
                if($HTTP_Status -eq 200){                             #Confirm there was a valid response
                    Write-Host "Site ""$url"" is up"
                    $urlList.Remove($url)                             #Remove successful URL from list of urls.
                    $HTTP_Response.Close()                            #Close HTTP response
                    break                                             #Go back to while loop
                }
            }
            catch{continue}
        }
    }
    if($urlList.Count -ne 0){                                         #At this point if there are urls in the array, a timeout occurred
        $urlList | % {Write-Error "Time-Out: Could not get a response from $_"}
        exit 1
    }
}
