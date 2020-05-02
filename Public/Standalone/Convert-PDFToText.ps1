function Convert-PDFToText {
    [CmdletBinding()]
    param(
        [string] $FilePath,
        [int[]] $Page
    )
    if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
        $ResolvedPath = Convert-Path -LiteralPath $FilePath
        $Source = [iText.Kernel.Pdf.PdfReader]::new($ResolvedPath)
        try {
            [iText.Kernel.Pdf.PdfDocument] $SourcePDF = [iText.Kernel.Pdf.PdfDocument]::new($Source);
            [iText.Kernel.Pdf.Canvas.Parser.Listener.LocationTextExtractionStrategy] $ExtractionStrategy = [iText.Kernel.Pdf.Canvas.Parser.Listener.LocationTextExtractionStrategy]::new()
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Convert-PDFToText - Processing document $ResolvedPath failed with error: $ErrorMessage"
        }

        $PagesCount = $SourcePDF.GetNumberOfPages()
        if ($Page.Count -eq 0) {
            for ($Count = 1; $Count -le $PagesCount; $Count++) {
                try {
                    $ExtractedPage = $SourcePDF.GetPage($Count)
                    [iText.Kernel.Pdf.Canvas.Parser.PdfTextExtractor]::GetTextFromPage($ExtractedPage, $ExtractionStrategy)
                } catch {
                    $ErrorMessage = $_.Exception.Message
                    Write-Warning "Convert-PDFToText - Processing document $ResolvedPath failed with error: $ErrorMessage"
                }
            }
        } else {
            foreach ($Count in $Page) {
                if ($Count -le $PagesCount -and $Count -gt 0) {
                    try {
                        $ExtractedPage = $SourcePDF.GetPage($Count)
                        [iText.Kernel.Pdf.Canvas.Parser.PdfTextExtractor]::GetTextFromPage($ExtractedPage, $ExtractionStrategy)
                    } catch {
                        $ErrorMessage = $_.Exception.Message
                        Write-Warning "Convert-PDFToText - Processing document $ResolvedPath failed with error: $ErrorMessage"
                    }
                } else {
                    Write-Warning "Convert-PDFToText - File $ResolvedPath doesn't contain page number $Count. Skipping."
                }
            }
        }
        try {
            $SourcePDF.Close()
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Convert-PDFToText - Closing document $FilePath failed with error: $ErrorMessage"
        }
    } else {
        Write-Warning "Convert-PDFToText - Path $FilePath doesn't exists. Terminating."
    }
}