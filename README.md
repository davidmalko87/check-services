# windows-service-monitor

> PowerShell script that monitors Windows services and sends an email alert when any automatic-startup service is found stopped.

[![CI](https://github.com/davidmalko87/windows-service-monitor/actions/workflows/ci.yml/badge.svg)](https://github.com/davidmalko87/windows-service-monitor/actions/workflows/ci.yml)
[![Version](https://img.shields.io/badge/version-1.2.0-blue)](CHANGELOG.md)
[![PowerShell](https://img.shields.io/badge/PowerShell-4.0%2B-blue?logo=powershell)](https://microsoft.com/powershell)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Windows-0078D6?logo=windows)](https://www.microsoft.com/windows)
[![Last Commit](https://img.shields.io/github/last-commit/davidmalko87/windows-service-monitor)](https://github.com/davidmalko87/windows-service-monitor/commits/main)
[![Open Issues](https://img.shields.io/github/issues/davidmalko87/windows-service-monitor)](https://github.com/davidmalko87/windows-service-monitor/issues)

## Why?

Windows does not natively send alerts when a service crashes or fails to start. Polling Task Manager or Event Viewer after the fact wastes time. This script slots into **Windows Task Scheduler** to run on a regular cadence, and emails you the moment any automatic-startup service is in a stopped state — before users start filing tickets.

## Features

| Feature | Description |
|---|---|
| Automatic service detection | Queries every service with `StartType = Automatic` and flags those in the `Stopped` state |
| Email alerts | Sends a formatted email listing all affected services via any SMTP server |
| Hostname identification | Includes the server name in the email subject for instant triage in multi-server environments |
| Zero dependencies | A single `.ps1` file — no modules, no NuGet packages, no setup scripts |
| Task Scheduler ready | Designed to run headlessly on any schedule via `powershell.exe -File` |

## Quick Start

### 1. Download

```powershell
git clone https://github.com/davidmalko87/windows-service-monitor.git
cd windows-service-monitor
```

### 2. Configure

Open `Check-Services.ps1` and update the three variables at the bottom of the file:

```powershell
$SMTPServer       = 'smtp.example.com'    # SMTP server hostname or IP
$FromEmailAddress = 'alerts@example.com'  # Sender address
$ToEmailAddress   = 'admin@example.com'   # Recipient address
```

### 3. Run

```powershell
.\Check-Services.ps1
```

No output means all automatic services are running. An email is sent only when stopped services are found.

## Configuration Reference

All configuration is done directly in `Check-Services.ps1`:

| Variable | Required | Description | Example |
|---|---|---|---|
| `$SMTPServer` | Yes | Hostname or IP of the SMTP relay | `'smtp.office365.com'` |
| `$FromEmailAddress` | Yes | Sender email address | `'alerts@corp.com'` |
| `$ToEmailAddress` | Yes | Recipient email address | `'ops-team@corp.com'` |

Or import the module and call the function directly:

```powershell
Import-Module .\WindowsServiceMonitor.psd1
Test-StoppedServices `
    -SMTPServer       'smtp.example.com' `
    -FromEmailAddress 'alerts@example.com' `
    -ToEmailAddress   'admin@example.com'
```

## Scheduling with Task Scheduler

1. Open **Task Scheduler** → Create Task
2. **Triggers** tab → New → set your interval (e.g. every 15 minutes)
3. **Actions** tab → New:
   - **Program:** `powershell.exe`
   - **Arguments:** `-NonInteractive -ExecutionPolicy Bypass -File "C:\path\to\Check-Services.ps1"`
4. **General** tab → run under an account with permissions to query services and send mail

## Example Alert Email

**Subject:** `Alert: Stopped Automatic Services on SERVER01`

```
The following services are not running:

Status   Name     DisplayName
------   ----     -----------
Stopped  wuauserv Windows Update
Stopped  BITS     Background Intelligent Transfer Service

Please check SERVER01 server immediately!
```

## Project Structure

```
windows-service-monitor/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.yml
│   │   └── feature_request.yml
│   ├── workflows/
│   │   ├── ci.yml        ← lint + Pester tests on every push/PR
│   │   ├── publish.yml   ← publish to PSGallery on v* tag
│   │   ├── release.yml   ← create GitHub Release on v* tag
│   │   └── stale.yml     ← close stale issues/PRs
│   ├── dependabot.yml
│   └── PULL_REQUEST_TEMPLATE.md
├── tests/
│   └── WindowsServiceMonitor.Tests.ps1
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
├── README.md
├── WindowsServiceMonitor.psd1   ← canonical version source
├── WindowsServiceMonitor.psm1   ← module (exported functions)
└── Check-Services.ps1           ← thin runner script
```

## Known Limitations

- **Windows only** — relies on `Get-Service` and `Send-MailMessage`, which require Windows. The linter runs on Linux/macOS in CI, but the script must be executed on Windows.
- **No SMTP authentication** — `Send-MailMessage` is used without credentials. For authenticated SMTP (Office 365, Gmail SMTP relay) you will need to add `-Credential` and `-UseSsl` parameters.
- **`Send-MailMessage` is deprecated** in PowerShell 7+ (though still functional). A future version may migrate to `Send-MgUserMail` or similar.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the semver policy, two-file update rule, and development workflow.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the full release history.

## License

[MIT](LICENSE) © 2024 David Malko
