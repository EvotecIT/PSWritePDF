function New-InternalPDF {
    [CmdletBinding()]
    param(
        [string] $FilePath
    )
    $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($FilePath)
    $Script:PDF = [iText.Kernel.Pdf.PdfDocument]::new($writer)
    $null = $pdf.AddNewPage()
    $document = [iText.Layout.Document]::new($pdf)
    $document
}