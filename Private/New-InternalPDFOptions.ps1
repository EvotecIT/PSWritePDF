function New-InternalPDFOptions {
    [CmdletBinding()]
    param(
        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom
    )

    if ($Script:Document) {
        if ($MarginLeft) {
            $Script:Document.SetLeftMargin($MarginLeft)
        }
        if ($MarginRight) {
            $Script:Document.SetRightMargin($MarginRight)
        }
        if ($MarginTop) {
            $Script:Document.SetTopMargin($MarginTop)
        }
        if ($MarginBottom) {
            $Script:Document.SetBottomMargin($MarginBottom)
        }
    } else {
        # If Document doesn't exists it means we're using New-PDFOptions before New-PDFPage
        # We update DocumentSettings and use it just in case New-PDFPage doesn't have those values used.
        # Workaround, ugly but don't see a better way
        $Script:PDFStart['DocumentSettings']['MarginTop'] = $MarginTop
        $Script:PDFStart['DocumentSettings']['MarginBottom'] = $MarginBottom
        $Script:PDFStart['DocumentSettings']['MarginLeft'] = $MarginLeft
        $Script:PDFStart['DocumentSettings']['MarginRight'] = $MarginRight
    }

    #if ($Settings.PageSize) {
    #   $Script:Document.GetPdfDocument().SetDefaultPageSize([iText.Kernel.Geom.PageSize]::($Settings.PageSize))
    # }
}