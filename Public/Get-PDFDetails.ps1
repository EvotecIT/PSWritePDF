function Get-PDFDetails {
    [CmdletBinding()]
    param(
        [iText.Kernel.Pdf.PdfDocument] $Document
    )
    if ($Document) {
        [iText.Layout.Document] $LayoutDocument = [iText.Layout.Document]::new($Document)

        $Output = [ordered] @{
            Author       = $Document.GetDocumentInfo().GetAuthor()
            Creator      = $Document.GetDocumentInfo().GetCreator()
            HashCode     = $Document.GetDocumentInfo().GetHashCode()
            Keywords     = $Document.GetDocumentInfo().GetKeywords()
            Producer     = $Document.GetDocumentInfo().GetProducer()
            Subject      = $Document.GetDocumentInfo().GetSubject()
            Title        = $Document.GetDocumentInfo().GetTitle()
            Trapped      = $Document.GetDocumentInfo().GetTrapped()
            Version      = $Document.GetPdfVersion()
            PagesNumber  = $Document.GetNumberOfPages()
            MarginLeft   = $LayoutDocument.GetLeftMargin()
            MarginRight  = $LayoutDocument.GetRightMargin()
            MarginBottom = $LayoutDocument.GetBottomMargin()
            MarginTop    = $LayoutDocument.GetTopMargin()
            Pages        = [ordered] @{ }
        }
        for ($a = 1; $a -le $Output.PagesNumber; $a++) {
            $Height = $Document.GetPage($a).GetPageSizeWithRotation().GetHeight()
            $Width = $Document.GetPage($a).GetPageSizeWithRotation().GetWidth()
            $NamedSize = Get-PDFNamedPageSize -Height $Height -Width $Width
            $Output['Pages']["$a"] = [PSCustomObject] @{
                Height   = $Height
                Width    = $Width
                Rotation = $Document.GetPage($a).GetRotation()
                Size     = $NamedSize.PageSize
                Rotated  = $NamedSize.Rotated
            }
        }
        [PSCustomObject] $Output
    }
}