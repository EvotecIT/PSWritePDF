function Get-PDFDetails {
    [CmdletBinding()]
    param(
        [iText.Kernel.Pdf.PdfDocument] $Document
    )
    if ($Document) {

        $Output = [ordered] @{
            Author      = $Document.GetDocumentInfo().GetAuthor()
            Creator     = $Document.GetDocumentInfo().GetCreator()
            HashCode    = $Document.GetDocumentInfo().GetHashCode()
            Keywords    = $Document.GetDocumentInfo().GetKeywords()
            Producer    = $Document.GetDocumentInfo().GetProducer()
            Subject     = $Document.GetDocumentInfo().GetSubject()
            Title       = $Document.GetDocumentInfo().GetTitle()
            Trapped     = $Document.GetDocumentInfo().GetTrapped()
            Version     = $Document.GetPdfVersion()
            PagesNumber = $Document.GetNumberOfPages()
            Pages       = [ordered] @{ }
        }
        for ($a = 1; $a -le $Output.PagesNumber; $a++) {
            $Output['Pages']["$a"] = [PSCustomObject] @{
                Height   = $Document.GetPage($a).GetPageSizeWithRotation().GetHeight()
                Width    = $Document.GetPage($a).GetPageSizeWithRotation().GetWidth()
                Rotation = $Document.GetPage($a).GetRotation()
            }
        }
        [PSCustomObject] $Output
    }
}

function Get-PageSize {
    param(
        [int] $Height,
        [int] $Width
    )

    if ($Height -eq 595 -and $Width -eq 842) {
        return @{ 'PageSize' = 'A4'; Rotated = $true }
    } elseif ($Height -eq 842 -and $Width -eq 595) {
        return @{ 'PageSize' = 'A4'; Rotated = $false }
    } elseif ($Height -eq 595 -and $Width -eq 420) {
        return @{ 'PageSize' = 'A5'; Roated = $false }
    }
}