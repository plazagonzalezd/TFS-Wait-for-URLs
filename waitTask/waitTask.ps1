[cmdletbinding()]
param(
        [string]$Urls,
        [int]$Seconds
    )
Import-Module .\waitTaskFunctions.psm1
Wait-Urls -urls $Urls -Seconds $Seconds
