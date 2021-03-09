function New-PDFText {
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

    if ($null -ne $Script:PDFStart -and $Script:PDFStart['Start']) {
        $Settings = [PSCustomObject] @{
            Type     = 'Text'
            Settings = $Splat
        }
        $Settings
    } else {
        New-InternalPDFText @Splat
    }
}

Register-ArgumentCompleter -CommandName New-PDFText -ParameterName Font -ScriptBlock $Script:PDFFontList
Register-ArgumentCompleter -CommandName New-PDFText -ParameterName FontColor -ScriptBlock $Script:PDFColor