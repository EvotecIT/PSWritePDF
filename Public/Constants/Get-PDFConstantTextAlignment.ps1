# Validation for Colors
$Script:PDFTextAlignments = {
    ([iText.Layout.Properties.TextAlignment] | Get-Member -static -MemberType Property).Name
}

function Get-PDFConstantTextAlignment {
    [CmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFTextAlignmentValidation } )][string] $TextAlignment
    )
    return [iText.Layout.Properties.TextAlignment]::$TextAlignment
}

Register-ArgumentCompleter -CommandName Get-PDFConstantTextAlignment -ParameterName TextAlignment -ScriptBlock $Script:PDFTextAlignments