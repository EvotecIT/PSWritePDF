function New-InternalPDFPage {
    [CmdletBinding()]
    param(
        [System.Collections.IDictionary] $Settings
    )

    if ($Settings.PageSize -or $Settings.Rotate) {
        if ($Settings.PageSize) {
            $PageSize = [iText.Kernel.Geom.PageSize]::($Settings.PageSize)
        }
        if ($Settings.Rotate) {
            if ($PageSize) {
                $PageSize = $PageSize.Rotate()
            } else {
                $PageSize = [iText.Kernel.Geom.PageSize]::A4
                $PageSize = $PageSize.Rotate()
            }
        }
    }
    if ($PageSize) {
        $null = $Script:PDF.AddNewPage($PageSize)
    } else {
        $null = $Script:PDF.AddNewPage()
    }


    $Script:Document = [iText.Layout.Document]::new($Script:PDF)
}