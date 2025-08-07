Describe 'Convert-PDFToText' {
    It 'extracts text from PDF' {
        $file = Join-Path $PSScriptRoot 'Input' 'SampleAcroForm.pdf'
        $text = Convert-PDFToText -FilePath $file
        ($text -join "`n") | Should -Match 'Text 1'
    }
    It 'accepts piped Get-ChildItem results' {
        $files = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Input') -Filter '*.pdf'
        $text = $files | Convert-PDFToText
        ($text -join "`n") | Should -Match 'Text 1'
    }
}
