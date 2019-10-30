function New-PDFText {
    [CmdletBinding()]
    param(
        [string[]] $Text
    )
    [PSCustomObject] @{
        Type     = 'Text'
        Settings = @{
            Text = $Text
        }
    }
}