<#
.SYNOPSIS
    Monitors Windows services and sends an email alert when automatic services are stopped.

.DESCRIPTION
    Queries all Windows services configured for Automatic startup. If any are found
    in a Stopped state, an email notification is sent to the specified recipient.
    Intended to be run periodically via Windows Task Scheduler.

.PARAMETER SMTPServer
    Hostname or IP address of the SMTP server used to send alert emails.

.PARAMETER FromEmailAddress
    The sender email address for alert notifications.

.PARAMETER ToEmailAddress
    The recipient email address for alert notifications.

.EXAMPLE
    Test-StoppedServices -SMTPServer "smtp.example.com" -FromEmailAddress "alerts@example.com" -ToEmailAddress "admin@example.com"

.NOTES
    Author: David Malko
    Requires: PowerShell 4.0 or later, Windows
#>
Function Test-StoppedServices {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$SMTPServer,

        [Parameter(Mandatory)]
        [string]$FromEmailAddress,

        [Parameter(Mandatory)]
        [string]$ToEmailAddress
    )

    $computerName = if ($env:COMPUTERNAME) { $env:COMPUTERNAME } else { [System.Net.Dns]::GetHostName() }

    try {
        $stoppedServices = Get-Service | Where-Object {
            ($_.Status -eq 'Stopped') -and ($_.StartType -eq 'Automatic')
        }

        if ($stoppedServices) {
            $stoppedServicesTable = $stoppedServices | Format-Table -AutoSize | Out-String
            $body = @"
The following services are not running:

$stoppedServicesTable

Please check $computerName server immediately!
"@
            Send-MailMessage `
                -From $FromEmailAddress `
                -To $ToEmailAddress `
                -Subject "Alert: Stopped Automatic Services on $computerName" `
                -Body $body `
                -SmtpServer $SMTPServer
        }
    }
    catch {
        Write-Error "An unexpected error occurred: $($_.Exception.Message)"
    }
}
