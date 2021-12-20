function Initialize-PDF {
    [CmdletBinding()]
    param(
        [Array] $Elements
    )
    foreach ($Element in $Elements) {
        $Splat = $Element.Settings
        if ($Splat) {
            Remove-EmptyValue -Hashtable $Splat
        }
        if ($Element.Type -eq 'Page') {
            if (-not $Script:PDFStart.FirstPageUsed) {
                #$Area = New-PDFArea -PageSize $Element.Settings.PageSize -Rotate:$Element.Settings.Rotate -AreaType ([iText.Layout.Properties.AreaBreakType]::LAST_PAGE)
                #New-InternalPDFPage -PageSize $Element.Settings.PageSize -Rotate:$Element.Settings.Rotate

                # This adds margings to first page if New-PDFOptions is used but no margins were defined on New-PDFPage
                if (-not $Splat.Margins.MarginBottom) {
                    $Splat.Margins.MarginBottom = $Script:PDFStart.DocumentSettings.MarginBottom
                }
                if (-not $Splat.Margins.MarginTop) {
                    $Splat.Margins.MarginTop = $Script:PDFStart.DocumentSettings.MarginTop
                }
                if (-not $Splat.Margins.MarginLeft) {
                    $Splat.Margins.MarginLeft = $Script:PDFStart.DocumentSettings.MarginLeft
                }
                if (-not $Splat.Margins.MarginRight) {
                    $Splat.Margins.MarginRight = $Script:PDFStart.DocumentSettings.MarginRight
                }
                New-InternalPDFPage -PageSize $Splat.PageSize -Rotate:$Splat.Rotate -MarginLeft $Splat.Margins.MarginLeft -MarginTop $Splat.Margins.MarginTop -MarginBottom $Splat.Margins.MarginBottom -MarginRight $Splat.Margins.MarginRight
                #Add-PDFDocumentContent -Object $Area
                $Script:PDFStart.FirstPageUsed = $true
            } else {
                # This fixes margins. Margins have to be added before new PageArea
                $SplatMargins = $Splat.Margins
                New-InternalPDFOptions @SplatMargins

                $Area = New-PDFArea -PageSize $Element.Settings.PageSize -Rotate:$Element.Settings.Rotate
                Add-PDFDocumentContent -Object $Area
            }
            # New-InternalPDFPage -PageSize $Element.Settings.PageSize -Rotate:$Element.Settings.Rotate
            # New-InternalPDFOptions -Settings $Element.Settings
            if ($Element.Settings.PageContent) {
                Initialize-PDF -Elements $Element.Settings.PageContent
            }
        } elseif ($Element.Type -eq 'Text') {
            $Paragraph = New-InternalPDFText @Splat
            foreach ($P in $Paragraph) {
                Add-PDFDocumentContent -Object $P
            }
        } elseif ($Element.Type -eq 'List') {
            New-InternalPDFList -Settings $Element.Settings
        } elseif ($Element.Type -eq 'Paragraph') {

        } elseif ($Element.Type -eq 'Options') {
            $SplatMargins = $Splat.Margins
            New-InternalPDFOptions @SplatMargins
        } elseif ($Element.Type -eq 'Table') {
            $Table = New-InteralPDFTable @Splat
            #$null = $Script:Document.Add($Table)
            Add-PDFDocumentContent -Object $Table
        } elseif ($Element.Type -eq 'Image') {
            New-InternalPDFImage @Splat
        }
    }
}