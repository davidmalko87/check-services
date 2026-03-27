#Requires -Version 4

# ---------------------------------------------------------------------------
# Configuration — update these values before running the script
# ---------------------------------------------------------------------------
$SMTPServer       = 'smtp.example.com'
$FromEmailAddress = 'alerts@example.com'
$ToEmailAddress   = 'admin@example.com'

Import-Module (Join-Path $PSScriptRoot 'WindowsServiceMonitor.psd1') -Force
Test-StoppedServices -SMTPServer $SMTPServer -FromEmailAddress $FromEmailAddress -ToEmailAddress $ToEmailAddress
