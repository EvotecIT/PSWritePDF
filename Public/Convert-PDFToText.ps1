function Convert-PDFToText {
    [CmdletBinding()]
    param(
        [string] $FilePath,
        [int[]] $Page,
        [switch] $All
    )
    if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
        $Source = [iText.Kernel.Pdf.PdfReader]::new($FilePath)
        [iText.Kernel.Pdf.PdfDocument] $SourcePDF = [iText.Kernel.Pdf.PdfDocument]::new($Source);
        [iText.Kernel.Pdf.Canvas.Parser.Listener.LocationTextExtractionStrategy] $ExtractionStrategy = [iText.Kernel.Pdf.Canvas.Parser.Listener.LocationTextExtractionStrategy]::new()

        if ($All) {
            $PagesCount = $SourcePDF.GetNumberOfPages()
            for ($Count = 1; $Count -le $PagesCount; $Count++) {
                $ExtractedPage = $SourcePDF.GetPage($Count)
                [iText.Kernel.Pdf.Canvas.Parser.PdfTextExtractor]::GetTextFromPage($ExtractedPage, $ExtractionStrategy)
            }
        } else {

        }

    } else {
        Write-Warning "Convert-PDFToText - Path $FilePath doesn't exists. Terminating."
    }
}
