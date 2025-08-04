Describe 'Get-PDFAction' {
    It 'returns specific action when name provided' {
        $result = Get-PDFAction -Action SUBMIT_PDF
        $result | Should -Be ([iText.Kernel.Pdf.Action.PdfAction]::SUBMIT_PDF)
    }
    It 'lists actions when All switch used' {
        $result = Get-PDFAction -All
        ($result -contains [PSWritePDF.PdfActionName]::SUBMIT_PDF) | Should -BeTrue
    }
}
