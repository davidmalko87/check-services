# Contributing

Thank you for considering a contribution to **windows-service-monitor**!

## Semantic Versioning Policy

This project follows [Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`):

| Change type | Version component |
|---|---|
| Bug fix, typo, documentation-only correction | PATCH (`x.y.Z`) |
| New feature, new parameter, new behaviour (backwards-compatible) | MINOR (`x.Y.0`) |
| Breaking change (renamed function, removed parameter, changed defaults) | MAJOR (`X.0.0`) |

## Two-File Update Rule

**Every change that ships in a release must update exactly these two files together in the same commit:**

1. **`WindowsServiceMonitor.psd1`** — bump `ModuleVersion` to the new semver value.
2. **`CHANGELOG.md`** — add a new `## [x.y.z] - YYYY-MM-DD` section documenting what changed.

Pull requests that change behaviour without updating both files will not be merged.

## Development Workflow

1. Fork the repository and create a feature branch from `main`.
2. Make your changes in `Check-Services.ps1` (and the manifest / changelog as above).
3. Run **PSScriptAnalyzer** and fix all warnings before opening a PR:
   ```powershell
   Install-Module PSScriptAnalyzer -Force -Scope CurrentUser
   Invoke-ScriptAnalyzer -Path . -Recurse -Severity Error,Warning
   ```
4. Open a pull request using the provided PR template and fill in every section.

## Code Style

- Follow [PowerShell Best Practices](https://poshcode.gitbook.io/powershell-practice-and-style/).
- Use approved PowerShell verbs (`Get-`, `Set-`, `Test-`, `Invoke-`, etc.).
- Use `$env:COMPUTERNAME` instead of the `hostname` command.
- Prefer single-quoted strings unless variable expansion is required.
- Keep the script self-contained — no external module dependencies.

## Reporting Issues

Use the GitHub issue templates for [bug reports](.github/ISSUE_TEMPLATE/bug_report.yml)
and [feature requests](.github/ISSUE_TEMPLATE/feature_request.yml).
