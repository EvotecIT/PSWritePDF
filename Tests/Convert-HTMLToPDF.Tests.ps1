Describe 'Convert-HTMLToPDF' {
    BeforeAll {
        New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output' | Out-Null
    }

    It 'converts HTML string to PDF' {
        $file = Join-Path $PSScriptRoot 'Output' 'converted.pdf'
        Convert-HTMLToPDF -Content '<html><body>Test</body></html>' -OutputFilePath $file
        Test-Path $file | Should -BeTrue
    }

    AfterAll {
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Output') -Recurse -Force
    }
}
