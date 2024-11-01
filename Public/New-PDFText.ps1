function New-PDFText {
    [CmdletBinding()]
    param(
        [string[]] $Text,
        [ValidateScript( { & $Script:PDFFontValidationList } )][string[]] $Font,
        [ValidateScript( { & $Script:PDFColorValidation } )][string[]] $FontColor,
        [nullable[bool][]] $FontBold,
        [int] $FontSize,
        [ValidateScript( { & $Script:PDFTextAlignmentValidation } )][string] $TextAlignment,
        [nullable[float]] $MarginTop = 2,
        [nullable[float]] $MarginBottom = 2,
        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight
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
    if ($FontSize) {
        $Splat['FontSize'] = $FontSize
    }
    if ($TextAlignment) {
        $Splat['TextAlignment'] = $TextAlignment
    }
    if ($MarginTop) {
        $Splat['MarginTop'] = $MarginTop
    }
    if ($MarginBottom) {
        $Splat['MarginBottom'] = $MarginBottom
    }
    if ($MarginLeft) {
        $Splat['MarginLeft'] = $MarginLeft
    }
    if ($MarginRight) {
        $Splat['MarginRight'] = $MarginRight
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
Register-ArgumentCompleter -CommandName New-PDFText -ParameterName HorizontalAlignment -ScriptBlock $Script:PDFTextAlignments