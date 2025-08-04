Describe 'Split-PDF' {
    BeforeAll {
        New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output' | Out-Null
    }

    It 'splits pdf into parts' {
        $file = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        Split-PDF -FilePath $file -OutputFolder (Join-Path $PSScriptRoot 'Output') -SplitCount 1 -OutputName 'part'
        (Get-ChildItem -Path (Join-Path $PSScriptRoot 'Output') -Filter 'part*.pdf').Count | Should -BeGreaterThan 1
    }

    AfterAll {
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Output') -Recurse -Force
    }
}
