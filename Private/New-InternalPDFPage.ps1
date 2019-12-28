function New-InternalPDFPage {
    [CmdletBinding()]
    param(
        [string] $PageSize,
        [switch] $Rotate,
        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom
    )

    if ($PageSize -or $Rotate) {
        if ($PageSize) {
            $Page = [iText.Kernel.Geom.PageSize]::($PageSize)
        } else {
            $Page = [iText.Kernel.Geom.PageSize]::Default
        }
        if ($Rotate) {
            $Page = $Page.Rotate()
        }
    }
    if ($Page) {
        $null = $Script:PDF.AddNewPage($Page)
    } else {
        $null = $Script:PDF.AddNewPage()
    }
    $Script:Document = [iText.Layout.Document]::new($Script:PDF)

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
}

Register-ArgumentCompleter -CommandName New-InternalPDFPage -ParameterName PageSize -ScriptBlock $Script:PDFPageSize