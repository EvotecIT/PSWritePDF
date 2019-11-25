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
    }

    #if ($Settings.PageSize) {
    #   $Script:Document.GetPdfDocument().SetDefaultPageSize([iText.Kernel.Geom.PageSize]::($Settings.PageSize))
    # }
}