function New-PDFTable {
    [CmdletBinding()]
    param(
        [Array] $DataTable
    )

    if ($DataTable[0] -is [System.Collections.IDictionary]) {
        [Array] $ColumnNames = $DataTable[0].Keys
    } else {
        [Array] $ColumnNames = $DataTable[0].PSObject.Properties.Name
    }

    [iText.layout.element.Table] $Table = [iText.layout.element.Table]::new($ColumnNames.Count)
    $Table = $Table.UseAllAvailableWidth()

    foreach ($Column in $ColumnNames) {
        $Paragraph = New-PDFText -Text $Column
        [iText.Layout.Element.Cell] $Cell = [iText.Layout.Element.Cell]::new().Add($Paragraph)
        $null = $table.AddCell($Cell)
    }
    foreach ($_ in $DataTable) {
        foreach ($Column in $ColumnNames) {
            $Paragraph = New-PDFText -Text $_.$Column
            [iText.Layout.Element.Cell] $Cell = [iText.Layout.Element.Cell]::new().Add($Paragraph)
            $null = $table.AddCell($Cell)
        }
    }
    $Table
}