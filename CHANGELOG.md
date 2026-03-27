# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2026-03-27

### Added
- `WindowsServiceMonitor.psm1` — function now lives in a proper PowerShell module file
- `tests/WindowsServiceMonitor.Tests.ps1` — Pester 5 test suite covering no-alert path,
  alert path (email sent with correct parameters and body), and error-handling path
- `.github/workflows/publish.yml` — publishes the module to PSGallery on every `v*` tag,
  with a pre-flight check that the manifest version matches the tag
- `.github/workflows/release.yml` — auto-creates a GitHub Release with changelog notes
  extracted from `CHANGELOG.md` on every `v*` tag
- `.github/workflows/stale.yml` — marks stale issues and PRs after 60 days of inactivity
- CI now installs Pester 5 and runs the test suite with JaCoCo code-coverage output

### Changed
- `WindowsServiceMonitor.psd1`: added `RootModule` and `FunctionsToExport`; removed
  `ScriptsToProcess`; version bumped to 1.2.0
- `Check-Services.ps1`: now a thin runner that imports the module and calls
  `Test-StoppedServices`
- `$env:COMPUTERNAME` falls back to `[System.Net.Dns]::GetHostName()` for cross-platform
  compatibility when running tests on Linux CI agents

## [1.1.2] - 2026-03-20

### Changed
- Rewrote README with shields.io badges, project structure tree, configuration reference,
  and professional GitHub standard layout

## [1.1.1] - 2026-03-20

### Changed
- Switched license from GPL-3.0 to MIT

## [1.1.0] - 2026-03-20

### Added
- Full comment-based help (`.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`, `.NOTES`)

### Changed
- Cleaned up script formatting and whitespace

## [1.0.0] - 2024-01-19

### Added
- Initial release of Windows Service Monitor
- `Test-StoppedServices` function to detect stopped automatic-startup services
- Email notification via `Send-MailMessage` with configurable SMTP server,
  sender, and recipient
- Hostname included in alert subject and body for quick server identification

[Unreleased]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.1.2...v1.2.0
[1.1.2]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/davidmalko87/windows-service-monitor/releases/tag/v1.0.0
