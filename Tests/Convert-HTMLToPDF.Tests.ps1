Describe 'Convert-HTMLToPDF' {
    BeforeAll {
        New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output' | Out-Null
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

    AfterAll {
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Output') -Recurse -Force
    }
}
