Describe 'Convert-HTMLToPDF' {
    BeforeAll {
        $outputDir = Join-Path $PSScriptRoot 'Output'
        if (Test-Path $outputDir) {
            Remove-Item -LiteralPath $outputDir -Recurse -Force
        }
        New-Item -Path $outputDir -ItemType Directory | Out-Null
    }

    It 'converts HTML string to PDF and outputs file path' {
        $file = Join-Path $PSScriptRoot 'Output' 'converted.pdf'
        $result = Convert-HTMLToPDF -Content '<html><body>Test</body></html>' -OutputFilePath $file
        Test-Path $file | Should -BeTrue
        $result | Should -Be $file
    }

    It 'overwrites existing file only when Force is used' {
        $file = Join-Path $PSScriptRoot 'Output' 'force.pdf'
        Convert-HTMLToPDF -Content '<html><body>First</body></html>' -OutputFilePath $file | Out-Null
        $timestamp = (Get-Item $file).LastWriteTime
        Start-Sleep -Seconds 1
        Convert-HTMLToPDF -Content '<html><body>Second</body></html>' -OutputFilePath $file | Out-Null
        (Get-Item $file).LastWriteTime | Should -Be $timestamp
        Convert-HTMLToPDF -Content '<html><body>Second</body></html>' -OutputFilePath $file -Force | Out-Null
        (Get-Item $file).LastWriteTime | Should -Not -Be $timestamp
    }

    It 'converts HTML from a URI' {
        $file = Join-Path $PSScriptRoot 'Output' 'uri.pdf'
        $result = Convert-HTMLToPDF -Uri 'https://example.com/' -OutputFilePath $file -Confirm:$false
        Test-Path $file | Should -BeTrue
        $result | Should -Be $file
    }

    AfterAll {
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Output') -Recurse -Force
    }
}
