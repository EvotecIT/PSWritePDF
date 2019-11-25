function New-PDFDocument {
    [CmdletBinding()]
    param(
        [iText.Kernel.Pdf.PdfDocument] $PDF
    )
    [iText.Layout.Document] $Document = [iText.Layout.Document]::new($PDF)
    return $Document
}