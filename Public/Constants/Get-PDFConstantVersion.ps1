# Validation for Fonts
$Script:PDFVersion = {
    ([iText.Kernel.Pdf.PdfVersion] | Get-Member -static -MemberType Property).Name
}
$Script:PDFVersionValidation = {
    $Array = @(
        (& $Script:PDFVersion)
        ''
    )
    $_ -in $Array
}

function Get-PDFConstantVersion {
    [CmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFVersionValidation } )][string] $Version
    )
    return [iText.Kernel.Pdf.PdfVersion]::$Version
}

Register-ArgumentCompleter -CommandName Get-PDFConstantVersion -ParameterName Version -ScriptBlock $Script:PDFVersion