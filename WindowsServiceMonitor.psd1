@{
    # Unique identifier for this module
    GUID              = '9a2f4d8c-b6e1-4c37-a815-f2d9e7b3c042'

    # Version of this module — this is the canonical version source for the project
    ModuleVersion     = '1.2.0'

    # Module file containing exported functions
    RootModule        = 'WindowsServiceMonitor.psm1'

    # Functions to export from this module
    FunctionsToExport = @('Test-StoppedServices')

    # Author
    Author            = 'David Malko'

    # Copyright
    Copyright         = '(c) 2024 David Malko. All rights reserved.'

    # Description
    Description       = 'Monitors Windows services and sends email alerts when automatic-startup services are found stopped.'

    # Minimum PowerShell version required
    PowerShellVersion = '4.0'

    # PSGallery metadata
    PrivateData       = @{
        PSData = @{
            Tags         = @('Windows', 'Services', 'Monitoring', 'Email', 'Alert', 'TaskScheduler')
            LicenseUri   = 'https://github.com/davidmalko87/windows-service-monitor/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/davidmalko87/windows-service-monitor'
            ReleaseNotes = 'See CHANGELOG.md for full release history.'
        }
    }
}
