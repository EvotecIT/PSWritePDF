Describe 'Get-PDFVersion' {
    It 'returns specific version when name provided' {
        $result = Get-PDFVersion -Version PDF_1_5
        $result | Should -Be ([iText.Kernel.Pdf.PdfVersion]::PDF_1_5)
    }
    It 'lists versions when All switch used' {
        $result = Get-PDFVersion -All
        ($result -contains [PSWritePDF.PdfVersionName]::PDF_1_5) | Should -BeTrue
    }
}
