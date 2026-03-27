# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.1.2...HEAD
[1.1.2]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/davidmalko87/windows-service-monitor/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/davidmalko87/windows-service-monitor/releases/tag/v1.0.0
