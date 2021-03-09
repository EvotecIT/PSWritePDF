function Get-InternalPDFFont {
    [cmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFFontValidationList } )][string] $Font
    )
    if (-not $Script:Fonts[$Font]) {
        # If not defined font, we use contstant fonts
        $ConvertedFont = Get-PDFConstantFont -Font $Font
        $ApplyFont = [iText.Kernel.Font.PdfFontFactory]::CreateFont($ConvertedFont)
    } else {
        # if defined we use whatever we defined
        $ApplyFont = $Script:Fonts[$Font]
    }
    $ApplyFont
}

Register-ArgumentCompleter -CommandName Get-InternalPDFFont -ParameterName Font -ScriptBlock $Script:PDFFontList