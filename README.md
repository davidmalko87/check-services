# check-services

A PowerShell script that monitors Windows services and sends an email alert when any service configured for **Automatic** startup is found in a **Stopped** state.

## Features

- Detects all Automatic-startup services that are not running
- Sends a formatted email alert listing the affected services
- Includes the server hostname in the email subject for quick identification
- Designed to be scheduled via Windows Task Scheduler for continuous monitoring

## Prerequisites

- Windows (any version with PowerShell 4.0 or later)
- Access to an SMTP server for sending email notifications
- Sufficient permissions to query services (`Get-Service`) and send mail (`Send-MailMessage`)

## Configuration

Edit the variables at the bottom of `Check-Services.ps1` before running:

```powershell
$SMTPServer       = "smtp.example.com"      # Your SMTP server address
$FromEmailAddress = "alerts@example.com"    # Sender email address
$ToEmailAddress   = "admin@example.com"     # Recipient email address
```

## Usage

Run the script directly from a PowerShell session:

```powershell
.\Check-Services.ps1
```

Or call the function manually with explicit parameters:

```powershell
. .\Check-Services.ps1

Check-Services `
    -SMTPServer "smtp.example.com" `
    -FromEmailAddress "alerts@example.com" `
    -ToEmailAddress "admin@example.com"
```

## Scheduling with Task Scheduler

To run the script automatically (e.g., every 15 minutes):

1. Open **Task Scheduler** and create a new task.
2. Set the **trigger** to repeat on your desired interval.
3. Set the **action** to:
   - **Program:** `powershell.exe`
   - **Arguments:** `-NonInteractive -ExecutionPolicy Bypass -File "C:\path\to\Check-Services.ps1"`
4. Run the task under an account with permission to query services and send mail.

## Example Alert Email

**Subject:** `Alert: Stopped Automatic Services on SERVER01`

**Body:**
```
The following services are not running:

Status   Name               DisplayName
------   ----               -----------
Stopped  wuauserv           Windows Update
Stopped  BITS               Background Intelligent Transfer Service

Please check SERVER01 server immediately!
```

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
