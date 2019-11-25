function New-InternalPDFPage {
    [CmdletBinding()]
    param(
        [string] $PageSize,
        [switch] $Rotate
    )


    if ($PageSize -or $Rotate) {
        if ($PageSize) {
            $Page = [iText.Kernel.Geom.PageSize]::($PageSize)
        }
        if ($Rotate) {
            if ($PageSize) {
                $Page = $Page.Rotate()
            } else {
                $Page = [iText.Kernel.Geom.PageSize]::A4
                $Page = $Page.Rotate()
            }
        }
    }
    if ($PageSize) {
        $null = $Script:PDF.AddNewPage($Page)
    } else {
        $null = $Script:PDF.AddNewPage()
    }
    $Script:Document = [iText.Layout.Document]::new($Script:PDF)
}

Register-ArgumentCompleter -CommandName New-InternalPDFPage -ParameterName PageSize -ScriptBlock $Script:PDFPageSize