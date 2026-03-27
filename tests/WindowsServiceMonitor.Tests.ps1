#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0' }

BeforeAll {
    Import-Module (Join-Path $PSScriptRoot '../WindowsServiceMonitor.psd1') -Force
}

Describe 'Test-StoppedServices' {

    Context 'when all automatic services are running' {

        BeforeEach {
            Mock -CommandName Get-Service -ModuleName WindowsServiceMonitor -MockWith { @() }
            Mock -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -MockWith {}
        }

        It 'does not send an email' {
            Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com'
            Should -Invoke -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -Times 0 -Exactly
        }
    }

    Context 'when stopped automatic services are found' {

        BeforeEach {
            $stoppedSvc = [PSCustomObject]@{
                Name        = 'wuauserv'
                DisplayName = 'Windows Update'
                Status      = 'Stopped'
                StartType   = 'Automatic'
            }
            Mock -CommandName Get-Service -ModuleName WindowsServiceMonitor -MockWith { @($stoppedSvc) }
            Mock -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -MockWith {}
        }

        It 'sends exactly one email' {
            Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com'
            Should -Invoke -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -Times 1 -Exactly
        }

        It 'uses the provided SMTP server' {
            Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com'
            Should -Invoke -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -Times 1 `
                -ParameterFilter { $SmtpServer -eq 'smtp.test' }
        }

        It 'sends from the correct address' {
            Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com'
            Should -Invoke -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -Times 1 `
                -ParameterFilter { $From -eq 'from@test.com' }
        }

        It 'sends to the correct address' {
            Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com'
            Should -Invoke -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -Times 1 `
                -ParameterFilter { $To -eq 'to@test.com' }
        }

        It 'includes the service name in the email body' {
            Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com'
            Should -Invoke -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -Times 1 `
                -ParameterFilter { $Body -match 'wuauserv' }
        }
    }

    Context 'when Get-Service throws an error' {

        BeforeEach {
            Mock -CommandName Get-Service -ModuleName WindowsServiceMonitor -MockWith { throw 'Access denied' }
            Mock -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -MockWith {}
        }

        It 'does not throw' {
            { Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com' } |
                Should -Not -Throw
        }

        It 'does not send an email' {
            Test-StoppedServices -SMTPServer 'smtp.test' -FromEmailAddress 'from@test.com' -ToEmailAddress 'to@test.com'
            Should -Invoke -CommandName Send-MailMessage -ModuleName WindowsServiceMonitor -Times 0 -Exactly
        }
    }
}
