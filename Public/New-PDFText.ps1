function New-PDFText {
    [CmdletBinding()]
    param(
        [string[]] $Text,
        [ValidateScript( { & $Script:PDFFontValidation } )][string[]] $Font,
        #[string[]] $FontFamily,
        [ValidateScript( { & $Script:PDFColorValidation } )][string[]] $FontColor,
        [bool[]] $FontBold
    )
    $Splat = @{
        Text      = $Text
        Font      = $Font
        #FontFamily = $FontFamily
        FontColor = $FontColor
        FontBold  = $FontBold
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

Register-ArgumentCompleter -CommandName New-PDFText -ParameterName Font -ScriptBlock $Script:PDFFont
Register-ArgumentCompleter -CommandName New-PDFText -ParameterName FontColor -ScriptBlock $Script:PDFColor