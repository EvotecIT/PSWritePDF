function Convert-PDFToText {
    <#
    .SYNOPSIS
    Converts PDF to TEXT

    .DESCRIPTION
    Converts PDF to TEXT

    .PARAMETER FilePath
    The path to the PDF file to convert

    .PARAMETER Page
    The page number to convert (default is all pages)

    .PARAMETER IgnoreProtection
    The switch will allow reading of PDF files that are "owner password" encrypted for protection/security (e.g. preventing copying of text, printing etc).
    The switch doesn't allow reading of PDF files that are "user password" encrypted (i.e. you cannot open them without the password)

    .EXAMPLE
    # Get all pages text
    Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf"

    .EXAMPLE
    # Get page 1 text only
    Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -Page 1

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        [string] $FilePath,
        [int[]] $Page,
        [switch] $IgnoreProtection
    )
    if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
        $ResolvedPath = Convert-Path -LiteralPath $FilePath
        $Source = [iText.Kernel.Pdf.PdfReader]::new($ResolvedPath)
        if ($IgnoreProtection) {
            $null = $Source.SetUnethicalReading($true)
        }
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