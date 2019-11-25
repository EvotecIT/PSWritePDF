function New-PDFArea {
    param(
        [iText.Layout.Properties.AreaBreakType] $AreaType = [iText.Layout.Properties.AreaBreakType]::NEXT_AREA,
        [string] $PageSize,
        [switch] $Rotate
    )
    $AreaBreak = [iText.Layout.Element.AreaBreak]::new($AreaType)
    if ($PageSize) {
        $Page = [iText.Kernel.Geom.PageSize]::($PageSize)
        if ($Rotate) {
            $Page = $Page.Rotate()
        }
        $AreaBreak.SetPageSize($Page)
    }
    return $AreaBreak
}

Register-ArgumentCompleter -CommandName New-PDFArea  -ParameterName PageSize -ScriptBlock $Script:PDFPageSize