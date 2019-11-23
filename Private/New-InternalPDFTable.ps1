function New-InteralPDFTable {
    [CmdletBinding()]
    param(
        [Array] $DataTable
    )

    if ($DataTable[0] -is [System.Collections.IDictionary]) {
        [Array] $ColumnNames = $DataTable[0].Keys
    } else {
        [Array] $ColumnNames = $DataTable[0].PSObject.Properties.Name
    }

    [iText.layout.element.Table] $Table = [iText.Layout.Element.Table]::new($ColumnNames.Count)
    $Table = $Table.UseAllAvailableWidth()

    foreach ($Column in $ColumnNames) {
        $Splat = @{
            Text = $Column
            #Font      = $Font
            #FontFamily = $FontFamily
            #FontColor = $FontColor
            #FontBold  = $FontBold
        }
        $Paragraph = New-InternalPDFText @Splat
        #$Paragraph = New-PDFText -Text $Column
        [iText.Layout.Element.Cell] $Cell = [iText.Layout.Element.Cell]::new().Add($Paragraph)
        $null = $Table.AddCell($Cell)
    }
    foreach ($_ in $DataTable) {
        foreach ($Column in $ColumnNames) {
            $Splat = @{
                Text = $_.$Column
                #Font      = $Font
                #FontFamily = $FontFamily
                #FontColor = $FontColor
                #FontBold  = $FontBold
            }
            $Paragraph = New-InternalPDFText @Splat
            #$Paragraph = New-PDFText -Text $_.$Column
            [iText.Layout.Element.Cell] $Cell = [iText.Layout.Element.Cell]::new().Add($Paragraph)
            $null = $Table.AddCell($Cell)
        }
    }
    $Table
}