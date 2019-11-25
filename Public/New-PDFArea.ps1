function New-PDFArea {
    param(
        [iText.Layout.Properties.AreaBreakType] $AreaType = [iText.Layout.Properties.AreaBreakType]::NEXT_AREA,
        [string] $PageSize,
        [switch] $Rotate
    )
    # https://api.itextpdf.com/iText7/dotnet/7.1.8/classi_text_1_1_kernel_1_1_geom_1_1_page_size.html
    $AreaBreak = [iText.Layout.Element.AreaBreak]::new($AreaType)
    if ($PageSize) {
        $Page = [iText.Kernel.Geom.PageSize]::($PageSize)
    } else {
        $Page = [iText.Kernel.Geom.PageSize]::Default
    }
    if ($Rotate) {
        $Page = $Page.Rotate()
    }
    $AreaBreak.SetPageSize($Page)
    return $AreaBreak
}

Register-ArgumentCompleter -CommandName New-PDFArea  -ParameterName PageSize -ScriptBlock $Script:PDFPageSize