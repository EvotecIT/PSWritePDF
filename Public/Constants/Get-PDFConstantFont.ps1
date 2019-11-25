# Validation for Fonts
$Script:PDFFont = {
    ([iText.IO.Font.Constants.StandardFonts] | Get-Member -static -MemberType Property).Name
}
$Script:PDFFontValidation = {
    $Array = @(
        (& $Script:PDFFont)
        ''
    )
    $_ -in $Array
}

function Get-PDFConstantFont {
    [CmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFFontValidation } )][string] $Font
    )
    return [iText.IO.Font.Constants.StandardFonts]::$Font
}

Register-ArgumentCompleter -CommandName Get-PDFConstantFont -ParameterName Font -ScriptBlock $Script:PDFFont