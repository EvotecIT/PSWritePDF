Describe 'Get-PDFPageSize' {
    It 'returns specific page size when name provided' {
        $result = Get-PDFPageSize -PageSize A4
        $result | Should -Be ([iText.Kernel.Geom.PageSize]::A4)
    }
    It 'lists page sizes when All switch used' {
        $result = Get-PDFPageSize -All
        ($result -contains [PSWritePDF.PdfPageSizeName]::A3) | Should -BeTrue
    }
}
