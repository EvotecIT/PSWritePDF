function Close-PDF {
    [CmdletBinding()]
    param(
        [iText.Kernel.Pdf.PdfDocument] $Document
    )
    if ($Document) {
        $Document.Close()
    }
}