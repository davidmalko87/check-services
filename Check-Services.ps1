#Requires -Version 4

Function Check-Services { #Beginning of Function
   [CmdletBinding()] 
    param(
        [Parameter(Mandatory)]
        [string]$SMTPServer,

        [Parameter(Mandatory)]
        [string]$FromEmailAddress,

        [Parameter(Mandatory)]
        [string]$ToEmailAddress
          )
            try {  # looking for stopped services
                      $stoppedServices = Get-Service | Where-Object {
                      ($_.Status -eq "Stopped") -and ($_.StartType -eq "Automatic")
                                  }
                if ($stoppedServices) {
                           $BetterViewStoppedServices = ($stoppedServices | Format-Table -AutoSize | Out-String)    # Make results of Get-Service beaitufl for email messsage
                           $body = @"
                                  The following services are not running:
                                  $BetterViewStoppedServices

                                  Please, check $hostname server immediately!
"@   # Place results of Get-Service in multiline for email message
                       Send-MailMessage -From $FromEmailAddress -To $ToEmailAddress -Subject "Alert: Stopped Automatic Services on $hostname server" -Body $body -SmtpServer $SMTPServer
                             }
                          }
                catch {
                 Write-Error "An unexpected error occurred: $($_.Exception.Message)"  # Throw error message in case of unexpected error
                   }
                               } #End of function

# Variables
$SMTPServer = "smtp.freesmtpservers.com"  # I used a testing SMTP for testing purposes. You can also test
$FromEmailAddress = "alerts@test.com"
$ToEmailAddress = "test@test.com"
$hostname = hostname  #To make subject of email message more personalized and useful

Check-Services -SMTPServer $SMTPServer -FromEmailAddress $FromEmailAddress -ToEmailAddress $ToEmailAddress

# Written by David Malko. I tried to purify my code visually, but I am not a pro developer :)