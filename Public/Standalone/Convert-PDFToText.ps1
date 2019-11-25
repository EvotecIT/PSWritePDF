function Convert-PDFToText {
    [CmdletBinding()]
    param(
        [string] $FilePath,
        [int[]] $Page
    )
    if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
        $Source = [iText.Kernel.Pdf.PdfReader]::new($FilePath)
        [iText.Kernel.Pdf.PdfDocument] $SourcePDF = [iText.Kernel.Pdf.PdfDocument]::new($Source);
        [iText.Kernel.Pdf.Canvas.Parser.Listener.LocationTextExtractionStrategy] $ExtractionStrategy = [iText.Kernel.Pdf.Canvas.Parser.Listener.LocationTextExtractionStrategy]::new()

        $PagesCount = $SourcePDF.GetNumberOfPages()
        if ($Page.Count -eq 0) {
            for ($Count = 1; $Count -le $PagesCount; $Count++) {
                $ExtractedPage = $SourcePDF.GetPage($Count)
                [iText.Kernel.Pdf.Canvas.Parser.PdfTextExtractor]::GetTextFromPage($ExtractedPage, $ExtractionStrategy)
            }
        } else {
            foreach ($Count in $Page) {
                if ($Count -le $PagesCount -and $Count -gt 0) {
                    $ExtractedPage = $SourcePDF.GetPage($Count)
                    [iText.Kernel.Pdf.Canvas.Parser.PdfTextExtractor]::GetTextFromPage($ExtractedPage, $ExtractionStrategy)
                } else {
                    Write-Warning "Convert-PDFToText - File $FilePath doesn't contain page number $Count. Skipping."
                }
            }
        }

    } else {
        Write-Warning "Convert-PDFToText - Path $FilePath doesn't exists. Terminating."
    }
}