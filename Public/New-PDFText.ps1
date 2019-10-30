function New-PDFText {
    [CmdletBinding()]
    param(
        [string[]] $Text,
        [ValidateScript( { & $Script:PDFFontValidation } )][string] $Font
    )
    [PSCustomObject] @{
        Type     = 'Text'
        Settings = @{
            Text = $Text
            Font = $Font
        }
    }
}

Register-ArgumentCompleter -CommandName New-PDFText -ParameterName Font -ScriptBlock $Script:PDFFont