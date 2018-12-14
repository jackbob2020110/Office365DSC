[CmdletBinding()]
param(
    [Parameter()]
    [string] 
    $CmdletModule = (Join-Path -Path $PSScriptRoot `
                                         -ChildPath "..\Stubs\Office365.psm1" `
                                         -Resolve)
)

Import-Module -Name (Join-Path -Path $PSScriptRoot `
                                -ChildPath "..\UnitTestHelper.psm1" `
                                -Resolve)

$Global:DscHelper = New-O365DscUnitTestHelper -StubModule $CmdletModule `
                                              -DscResource "EXOMailTips"
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope

        $secpasswd = ConvertTo-SecureString "test@password1" -AsPlainText -Force
        $GlobalAdminAccount = New-Object System.Management.Automation.PSCredential ("tenantadmin", $secpasswd)

        Mock Invoke-ExoCommand {
            return Invoke-Command -ScriptBlock $ScriptBlock -ArgumentList $Arguments -NoNewScope
        }

        # Test contexts 
        Context -Name "MailTips are Disabled and should be Enabled" -Fixture {
            $testParams = @{
                Organization = "contoso.onmicrosoft.com"
                MailTipsAllTipsEnabled = $True
                Ensure = "Present"
                GlobalAdminAccount = $GlobalAdminAccount
            }

            Mock -CommandName Get-OrganizationConfig -MockWith { 
                return @{
                    MailTipsAllTipsEnabled = $False
                }
            }

            Mock -CommandName Set-OrganizationConfig -MockWith {

            }

            It "Should return False from the Get method" {
                (Get-TargetResource @testParams).MailTipsAllTipsEnabled | Should Be $False
            }

            It "Should set MailTipsAllTipsEnabled to True with the Set method" {
                Set-TargetResource @testParams
            }
        }

        Context -Name "MailTipsGroupMetricsEnabled are Disabled and should be Enabled" -Fixture {
            $testParams = @{
                Organization = "contoso.onmicrosoft.com"
                MailTipsGroupMetricsEnabled = $True
                Ensure = "Present"
                GlobalAdminAccount = $GlobalAdminAccount
            }

            Mock -CommandName Get-OrganizationConfig -MockWith { 
                return @{
                    MailTipsGroupMetricsEnabled = $False
                }
            }

            Mock -CommandName Set-OrganizationConfig -MockWith {

            }

            It "Should return False from the Get method" {
                (Get-TargetResource @testParams).MailTipsGroupMetricsEnabled | Should Be $False
            }

            It "Should set MailTipsGroupMetricsEnabled to True with the Set method" {
                Set-TargetResource @testParams
            }
        }
        
        Context -Name "MailTipsLargeAudienceThreshold are Disabled and should be Enabled" -Fixture {
            $testParams = @{
                Organization = "contoso.onmicrosoft.com"
                MailTipsLargeAudienceThreshold = $True
                Ensure = "Present"
                GlobalAdminAccount = $GlobalAdminAccount
            }

            Mock -CommandName Get-OrganizationConfig -MockWith { 
                return @{
                    MailTipsLargeAudienceThreshold = $False
                }
            }

            Mock -CommandName Set-OrganizationConfig -MockWith {

            }

            It "Should return False from the Get method" {
                (Get-TargetResource @testParams).MailTipsLargeAudienceThreshold | Should Be $False
            }

            It "Should set MailTipsLargeAudienceThreshold to True with the Set method" {
                Set-TargetResource @testParams
            }
        }
        
        Context -Name "MailTipsMailboxSourcedTipsEnabled are Disabled and should be Enabled" -Fixture {
            $testParams = @{
                Organization = "contoso.onmicrosoft.com"
                MailTipsMailboxSourcedTipsEnabled = $True
                Ensure = "Present"
                GlobalAdminAccount = $GlobalAdminAccount
            }

            Mock -CommandName Get-OrganizationConfig -MockWith { 
                return @{
                    MailTipsMailboxSourcedTipsEnabled = $False
                }
            }

            Mock -CommandName Set-OrganizationConfig -MockWith {

            }

            It "Should return False from the Get method" {
                (Get-TargetResource @testParams).MailTipsMailboxSourcedTipsEnabled | Should Be $False
            }

            It "Should set MailTipsMailboxSourcedTipsEnabled to True with the Set method" {
                Set-TargetResource @testParams
            }
        }
        
        Context -Name "MailTipsExternalRecipientsTipsEnabled are Disabled and should be Enabled" -Fixture {
            $testParams = @{
                Organization = "contoso.onmicrosoft.com"
                MailTipsExternalRecipientsTipsEnabled = $True
                Ensure = "Present"
                GlobalAdminAccount = $GlobalAdminAccount
            }

            Mock -CommandName Get-OrganizationConfig -MockWith { 
                return @{
                    MailTipsExternalRecipientsTipsEnabled = $False
                }
            }

            Mock -CommandName Set-OrganizationConfig -MockWith {

            }

            It "Should return False from the Get method" {
                (Get-TargetResource @testParams).MailTipsExternalRecipientsTipsEnabled | Should Be $False
            }

            It "Should set MailTipsExternalRecipientsTipsEnabled to True with the Set method" {
                Set-TargetResource @testParams
            }
        }
        

        Context -Name "ReverseDSC Tests" -Fixture {
            $testParams = @{
                Organization = "contoso.onmicrosoft.com"
                GlobalAdminAccount = $GlobalAdminAccount
            }

            Mock -CommandName Get-OrganizationConfig -MockWith {
                return @{
                    Organization = $Organization
                    MailTipsAllTipsEnabled = $True
                    MailTipsGroupMetricsEnabled = $True
                    MailTipsLargeAudienceThreshold = $True
                    MailTipsMailboxSourcedTipsEnabled = $True
                    MailTipsExternalRecipientsTipsEnabled = $True
                }
            }

            It "Should Reverse Engineer resource from the Export method" {
                Export-TargetResource @testParams
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope