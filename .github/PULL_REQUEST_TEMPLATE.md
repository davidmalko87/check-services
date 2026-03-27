## Summary

<!-- Describe what this PR does and why. Link any related issues with "Fixes #NNN". -->

## Type of Change

- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Refactor (no functional change)
- [ ] Documentation only

## Checklist

- [ ] Tested locally on Windows with PowerShell 5.1 or later
- [ ] `Invoke-ScriptAnalyzer -Path . -Recurse -Severity Error,Warning` returns no issues
- [ ] `ModuleVersion` in `WindowsServiceMonitor.psd1` has been bumped
- [ ] `CHANGELOG.md` has been updated with the new version and changes
- [ ] README updated if behaviour, configuration, or usage changed
