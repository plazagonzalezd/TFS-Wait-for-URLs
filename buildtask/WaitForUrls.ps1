
[cmdletbinding()]
param(
        [string]$urls,
        [int]$timeoutMinutes
    )
$timeout = new-timespan -Minutes $timeoutMinutes
$sw = [diagnostics.stopwatch]::StartNew()
$urlList = [System.Collections.ArrayList]($urls -split ",")
Write-Host "Trying to contact the following site(s): ""$urls"""
while($urlList.Count -ne 0 -and $sw.Elapsed -lt $timeout){
  foreach($url in $urlList){
    try{
      $HTTP_Request = [System.Net.WebRequest]::Create($url)
      $HTTP_Response = $HTTP_Request.GetResponse()
      $HTTP_Status = [int]$HTTP_Response.StatusCode
      if($HTTP_Status -eq 200){
        Write-Host "Site ""$url"" is up"
        $urlList.Remove($url)
        $HTTP_Response.Close()
        break
      }
    }
    catch{continue}
  }
}
if($urlList.Count -ne 0) {
  $urlList | % {Write-Error "Time-Out: Could not get a response from $_"}
  exit 1
}
