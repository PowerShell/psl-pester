if ($PSVersionTable.PSVersion.Major -le 2) { return }

InModuleScope Pester {
    Describe 'Code Coverage Analysis' {
        $root = (Get-PSDrive TestDrive).Root
        $path = (Join-Path -Path $root -ChildPath "TestScript.ps1")

        $null = New-Item -Path $path -ItemType File -ErrorAction SilentlyContinue

        Set-Content -Path $path -Value @'
            function FunctionOne
            {
                function NestedFunction
                {
                    'I am the nested function.'
                    'I get fully executed.'
                }

                if ($true)
                {
                    'I am functionOne'
                    NestedFunction
                }
            }

            function FunctionTwo
            {
                'I am function two.  I never get called.'
            }

            FunctionOne

'@

        Context 'Entire file' {
            $testState = New-PesterState -Path $root

            # Path deliberately duplicated to make sure the code doesn't produce multiple breakpoints for the same commands
            Enter-CoverageAnalysis -CodeCoverage $path, $path -PesterState $testState

            It 'Has the proper number of breakpoints defined' {
                $testState.CommandCoverage.Count | Should Be 7
            }

            $null = & "$path"
            $coverageReport = Get-CoverageReport -PesterState $testState

            It 'Reports the proper number of executed commands' {
                $coverageReport.NumberOfCommandsExecuted | Should Be 6
            }

            It 'Reports the proper number of analyzed commands' {
                $coverageReport.NumberOfCommandsAnalyzed | Should Be 7
            }

            It 'Reports the proper number of analyzed files' {
                $coverageReport.NumberOfFilesAnalyzed | Should Be 1
            }

            It 'Reports the proper number of missed commands' {
                $coverageReport.MissedCommands.Count | Should Be 1
            }

            It 'Reports the correct missed command' {
                $coverageReport.MissedCommands[0].Command | Should Be "'I am function two.  I never get called.'"
            }

            It 'Reports the proper number of hit commands' {
                $coverageReport.HitCommands.Count | Should Be 6
            }

            It 'Reports the correct hit command' {
                $coverageReport.HitCommands[0].Command | Should Be "'I am the nested function.'"
            }

            Exit-CoverageAnalysis -PesterState $testState
        }

        Context 'Single function with missed commands' {
            $testState = New-PesterState -Path $root

            Enter-CoverageAnalysis -CodeCoverage @{Path = $path; Function = 'FunctionTwo'} -PesterState $testState

            It 'Has the proper number of breakpoints defined' {
                $testState.CommandCoverage.Count | Should Be 1
            }

            $null = & "$path"
            $coverageReport = Get-CoverageReport -PesterState $testState

            It 'Reports the proper number of executed commands' {
                $coverageReport.NumberOfCommandsExecuted | Should Be 0
            }

            It 'Reports the proper number of analyzed commands' {
                $coverageReport.NumberOfCommandsAnalyzed | Should Be 1
            }

            It 'Reports the proper number of missed commands' {
                $coverageReport.MissedCommands.Count | Should Be 1
            }

            It 'Reports the correct missed command' {
                $coverageReport.MissedCommands[0].Command | Should Be "'I am function two.  I never get called.'"
            }

            It 'Reports the proper number of hit commands' {
                $coverageReport.HitCommands.Count | Should Be 0
            }

            Exit-CoverageAnalysis -PesterState $testState
        }

        Context 'Single function with no missed commands' {
            $testState = New-PesterState -Path $root

            Enter-CoverageAnalysis -CodeCoverage @{Path = $path; Function = 'FunctionOne'} -PesterState $testState

            It 'Has the proper number of breakpoints defined' {
                $testState.CommandCoverage.Count | Should Be 5
            }

            $null = & "$path"
            $coverageReport = Get-CoverageReport -PesterState $testState

            It 'Reports the proper number of executed commands' {
                $coverageReport.NumberOfCommandsExecuted | Should Be 5
            }

            It 'Reports the proper number of analyzed commands' {
                $coverageReport.NumberOfCommandsAnalyzed | Should Be 5
            }

            It 'Reports the proper number of missed commands' {
                $coverageReport.MissedCommands.Count | Should Be 0
            }

            It 'Reports the proper number of hit commands' {
                $coverageReport.HitCommands.Count | Should Be 5
            }

            It 'Reports the correct hit command' {
                $coverageReport.HitCommands[0].Command | Should Be "'I am the nested function.'"
            }

            Exit-CoverageAnalysis -PesterState $testState
        }

        Context 'Range of lines' {
            $testState = New-PesterState -Path $root

            Enter-CoverageAnalysis -CodeCoverage @{Path = $path; StartLine = 11; EndLine = 12 } -PesterState $testState

            It 'Has the proper number of breakpoints defined' {
                $testState.CommandCoverage.Count | Should Be 2
            }

            $null = & "$path"
            $coverageReport = Get-CoverageReport -PesterState $testState

            It 'Reports the proper number of executed commands' {
                $coverageReport.NumberOfCommandsExecuted | Should Be 2
            }

            It 'Reports the proper number of analyzed commands' {
                $coverageReport.NumberOfCommandsAnalyzed | Should Be 2
            }

            It 'Reports the proper number of missed commands' {
                $coverageReport.MissedCommands.Count | Should Be 0
            }

            It 'Reports the proper number of hit commands' {
                $coverageReport.HitCommands.Count | Should Be 2
            }

            It 'Reports the correct hit command' {
                $coverageReport.HitCommands[0].Command | Should Be "'I am functionOne'"
            }

            Exit-CoverageAnalysis -PesterState $testState
        }

        Context 'Wildcard resolution' {
            $testState = New-PesterState -Path $root

            Enter-CoverageAnalysis -CodeCoverage @{Path = (Join-Path -Path $root -ChildPath "*.ps1"); Function = '*' } -PesterState $testState

            It 'Has the proper number of breakpoints defined' {
                $testState.CommandCoverage.Count | Should Be 6
            }

            $null = & "$path"
            $coverageReport = Get-CoverageReport -PesterState $testState

            It 'Reports the proper number of executed commands' {
                $coverageReport.NumberOfCommandsExecuted | Should Be 5
            }

            It 'Reports the proper number of analyzed commands' {
                $coverageReport.NumberOfCommandsAnalyzed | Should Be 6
            }

            It 'Reports the proper number of analyzed files' {
                $coverageReport.NumberOfFilesAnalyzed | Should Be 1
            }

            It 'Reports the proper number of missed commands' {
                $coverageReport.MissedCommands.Count | Should Be 1
            }

            It 'Reports the correct missed command' {
                $coverageReport.MissedCommands[0].Command | Should Be "'I am function two.  I never get called.'"
            }

            It 'Reports the proper number of hit commands' {
                $coverageReport.HitCommands.Count | Should Be 5
            }

            It 'Reports the correct hit command' {
                $coverageReport.HitCommands[0].Command | Should Be "'I am the nested function.'"
            }

            Exit-CoverageAnalysis -PesterState $testState
        }
    }

    Describe 'Stripping common parent paths' {
        $root = (Get-PSDrive TestDrive).Root
        $common = (Join-Path -Path $root -ChildPath "Common")
        $folder = (Join-Path -Path $common -ChildPath "Folder")
        $paths = @(
            (Join-Path -Path (Join-Path -Path $folder -ChildPath "UniqueSubFolder1") -ChildPath "File.ps1")
            (Join-Path -Path (Join-Path -Path $folder -ChildPath "UniqueSubFolder2") -ChildPath "File.ps2")
            (Join-Path -Path (Join-Path -Path $folder -ChildPath "UniqueSubFolder3") -ChildPath "File.ps3")
        )

        $commonPath = Get-CommonParentPath -Path $paths

        It 'Identifies the correct parent path' {
            $commonPath | Should Be $folder
        }

        It 'Strips the common path correctly' {
            $temp = Get-RelativePath -Path $paths[0] -RelativeTo $commonPath
            $temp | Should Be (Join-Path -Path UniqueSubfolder1 -ChildPath "File.ps1")
        }
    }

    if ((Get-Module -ListAvailable PSDesiredStateConfiguration) -and $PSVersionTable.PSVersion.Major -ge 4)
    {
        Describe 'Analyzing coverage of a DSC configuration' {
            $root = (Get-PSDrive TestDrive).Root
            $path = (Join-Path -Path $root -ChildPath "TestScriptWithConfiguration.ps1")

            $null = New-Item -Path $path -ItemType File -ErrorAction SilentlyContinue

            Set-Content -Path $path -Value @'
                $line1 = $true   # Triggers breakpoint
                $line2 = $true   # Triggers breakpoint

                configuration MyTestConfig   # does NOT trigger breakpoint
                {
                    Node localhost    # Triggers breakpoint
                    {
                        WindowsFeature XPSViewer   # Triggers breakpoint
                        {
                            Name = 'XPS-Viewer'  # does NOT trigger breakpoint
                            Ensure = 'Present'   # does NOT trigger breakpoint
                        }
                    }

                    return # does NOT trigger breakpoint

                    $doesNotExecute = $true   # Triggers breakpoint
                }

                $line3 = $true   # Triggers breakpoint

                return   # does NOT trigger breakpoint

                $doesnotexecute = $true   # Triggers breakpoint
'@

            $testState = New-PesterState -Path $root

            Enter-CoverageAnalysis -CodeCoverage $path -PesterState $testState

            It 'Has the proper number of breakpoints defined' {
                $testState.CommandCoverage.Count | Should Be 7
            }

            $null = . "$path"

            $coverageReport = Get-CoverageReport -PesterState $testState
            It 'Reports the proper number of missed commands before running the configuration' {
                $coverageReport.MissedCommands.Count | Should Be 4
            }

            MyTestConfig -OutputPath $root

            $coverageReport = Get-CoverageReport -PesterState $testState
            It 'Reports the proper number of missed commands after running the configuration' {
                $coverageReport.MissedCommands.Count | Should Be 2
            }

            Exit-CoverageAnalysis -PesterState $testState
        }
    }
}
