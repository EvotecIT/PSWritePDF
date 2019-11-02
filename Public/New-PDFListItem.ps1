function New-PDFListItem {
    [CmdletBinding()]
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