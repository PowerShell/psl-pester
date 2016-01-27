Set-StrictMode -Version Latest

InModuleScope Pester {
    Describe "PesterContain" {
        Context "when testing file contents" {
            Setup -File "test.txt" "this is line 1`nrush is awesome"
            It "returns true if the file contains the specified content" {
                Test-PositiveAssertion (PesterContain (Join-Path -Path $TestDrive -ChildPath "test.txt") "rush")
            }
            It "returns true if the file contains the specified content with different case" {
                Test-PositiveAssertion (PesterContain (Join-Path -Path $TestDrive -ChildPath "test.txt") "RUSH")
            }

            It "returns false if the file does not contain the specified content" {
                Test-NegativeAssertion (PesterContain (Join-Path -Path $TestDrive -ChildPath "test.txt") "slime")
            }
        }
    }
}
