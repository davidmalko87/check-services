# windows-service-monitor

> PowerShell script that monitors Windows services and sends an email alert when an auto-start service is found stopped.

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey?logo=windows)

## What It Does

Queries all Windows services configured for **Automatic** startup and alerts you via email the moment any of them is in a **Stopped** state. Designed to run on a schedule via Windows Task Scheduler — set it and forget it.

## Features

- Detects all Automatic-startup services that are not running
- Sends a formatted email alert listing every affected service
- Includes the server hostname in the email subject for quick identification
- Lightweight — a single `.ps1` file, no dependencies

## Requirements

- Windows with PowerShell 5.1 or later
- Access to an SMTP server (local relay or external service)
- Permissions to query services (`Get-Service`) and send mail (`Send-MailMessage`)

## Configuration

Edit the variables at the top of `Check-Services.ps1` before running:

```powershell
$SMTPServer        = "smtp.example.com"    # Your SMTP server address
$FromEmailAddress  = "alerts@example.com"  # Sender email address
$ToEmailAddress    = "admin@example.com"   # Recipient email address
```

## Usage

Run directly from a PowerShell session:

```powershell
.\Check-Services.ps1
```

Or call the function with explicit parameters:

```powershell
. .\Check-Services.ps1
Check-Services `
    -SMTPServer       "smtp.example.com" `
    -FromEmailAddress "alerts@example.com" `
    -ToEmailAddress   "admin@example.com"
```

## Scheduling with Task Scheduler

To run the check automatically (e.g., every 15 minutes):

1. Open **Task Scheduler** and create a new task
2. Set the trigger to repeat on your desired interval
3. Set the action: **Program:** `powershell.exe` | **Arguments:** `-NonInteractive -ExecutionPolicy Bypass -File "C:\path\to\Check-Services.ps1"`
4. Run the task under an account with permission to query services and send mail

## Example Alert Email

**Subject:** `Alert: Stopped Automatic Services on SERVER01`

```
The following services are not running:

Status   Name     DisplayName
------   ----     -----------
Stopped  wuauserv Windows Update
Stopped  BITS     Background Intelligent Transfer Service

Please check SERVER01 immediately!
```

## License

[MIT](LICENSE) © 2026 David Malko
