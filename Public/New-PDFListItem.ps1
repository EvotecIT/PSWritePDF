function New-PDFListItem {
    param(
        [string] $Text
    )
    [PSCustomObject] @{
        Type     = 'ListItem'
        Settings = @{
            Text = $Text
        }
    }
}