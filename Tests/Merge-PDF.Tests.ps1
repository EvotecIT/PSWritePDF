Describe 'Merge-PDF' {
    BeforeAll {
        New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output' | Out-Null
    }

    It 'merges pdf files' {
        $file1 = Join-Path $PSScriptRoot 'Input' 'SampleAcroForm.pdf'
        $file2 = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        $output = Join-Path $PSScriptRoot 'Output' 'merged.pdf'
        Merge-PDF -InputFile $file1, $file2 -OutputFile $output
        Test-Path $output | Should -BeTrue
    }

    It 'merges using provider paths' {
        $file1 = Join-Path $PSScriptRoot 'Input' 'SampleAcroForm.pdf'
        $file2 = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        $td1 = Join-Path TestDrive: 'f1.pdf'
        $td2 = Join-Path TestDrive: 'f2.pdf'
        Copy-Item $file1 $td1
        Copy-Item $file2 $td2
        $output = Join-Path TestDrive: 'merged.pdf'
        Merge-PDF -InputFile $td1, $td2 -OutputFile $output
        Test-Path $output | Should -BeTrue
    }

    AfterAll {
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Output') -Recurse -Force
    }
}
