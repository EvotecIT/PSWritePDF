Describe 'Convert-PDFToText' {
    It 'returns objects with PageNumber and Text' {
        $file = [IO.Path]::Combine($PSScriptRoot, 'Input', 'SampleAcroForm.pdf')
        $text = Convert-PDFToText -FilePath $file
        $text | ForEach-Object { $_ | Should -BeOfType [psobject] }
        $text[0].PageNumber | Should -Be 1
        $text[0].Text | Should -Match 'Text 1'
    }
    It 'accepts piped Get-ChildItem results' {
        $files = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Input') -Filter '*.pdf'
        $text = $files | Convert-PDFToText
        ($text | Select-Object -ExpandProperty Text | Out-String) | Should -Match 'Text 1'
    }
    It 'creates output file with combined text' {
        $file = Join-Path $PSScriptRoot 'Input' 'SampleAcroForm.pdf'
        $outFile = Join-Path $TestDrive 'output.txt'
        $result = Convert-PDFToText -FilePath $file -OutFile $outFile
        Test-Path $outFile | Should -BeTrue
        ($result | Select-Object -ExpandProperty Text | Out-String) | Should -Match 'Text 1'
        (Get-Content $outFile -Raw) | Should -Match 'Text 1'
    }

    It 'supports provider paths' {
        $src = Join-Path $PSScriptRoot 'Input' 'SampleAcroForm.pdf'
        $file = Join-Path TestDrive: 'sample.pdf'
        Copy-Item $src $file
        $text = Convert-PDFToText -FilePath $file
        $text[0].Text | Should -Match 'Text 1'
    }
}
