function New-PDFListItem {
    [CmdletBinding()]
    param(
        [string[]] $Text,
        [ValidateScript( { & $Script:PDFFontValidationList } )][string[]] $Font,
        [ValidateScript( { & $Script:PDFColorValidation } )][string[]] $FontColor,
        [nullable[bool][]] $FontBold
    )

    $Splat = @{ }
    if ($Text) {
        $Splat['Text'] = $Text
    }
    if ($Font) {
        $Splat['Font'] = $Font
    }
    if ($FontColor) {
        $Splat['FontColor'] = $FontColor
    }
    if ($FontBold) {
        $Splat['FontBold'] = $FontBold
    }

    [PSCustomObject] @{
        Type     = 'ListItem'
        Settings = $Splat
    }
}

Register-ArgumentCompleter -CommandName New-PDFListItem -ParameterName Font -ScriptBlock $Script:PDFFontList
Register-ArgumentCompleter -CommandName New-PDFListItem -ParameterName FontColor -ScriptBlock $Script:PDFColor