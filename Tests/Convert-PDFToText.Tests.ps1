Describe 'Convert-PDFToText' {
    It 'extracts text from PDF' {
        $file = Join-Path $PSScriptRoot 'Input' 'SampleAcroForm.pdf'
        $text = Convert-PDFToText -FilePath $file
        ($text -join "`n") | Should -Match 'Text 1'
    }
}
