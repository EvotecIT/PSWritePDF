function Get-PDFConstantFont {
    [CmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFFontValidation } )][string] $Font
    )
    return [iText.IO.Font.Constants.StandardFonts]::$Font
}

Register-ArgumentCompleter -CommandName Get-PDFConstantFont -ParameterName Font -ScriptBlock $Script:PDFFont