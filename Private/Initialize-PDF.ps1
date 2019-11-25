function Initialize-PDF {
    [CmdletBinding()]
    param(
        [Array] $Elements
    )
    foreach ($Element in $Elements) {
        $Splat = $Element.Settings
        Remove-EmptyValues -Hashtable $Splat
        if ($Element.Type -eq 'Page') {
            if (-not $Script:PDFStart.FirstPageUsed) {
                $Area = New-PDFArea -PageSize $Element.Settings.PageSize -Rotate:$Element.Settings.Rotate -AreaType ([iText.Layout.Properties.AreaBreakType]::LAST_PAGE)
                Add-PDFDocumentContent -Object $Area
                $Script:PDFStart.FirstPageUsed = $true
            } else {
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
                #$null = $Script:Document.Add($P)
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
        }
    }
}