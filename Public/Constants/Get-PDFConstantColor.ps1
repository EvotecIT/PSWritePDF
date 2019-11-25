# Validation for Colors
$Script:PDFColor = {
    ([iText.Kernel.Colors.ColorConstants] | Get-Member -static -MemberType Property).Name
}
$Script:PDFColorValidation = {
    $Array = @(
        (& $Script:PDFColor)
        ''
    )
    $_ -in $Array
}

function Get-PDFConstantColor {
    [CmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFColorValidation } )][string] $Color
    )
    return [iText.Kernel.Colors.ColorConstants]::$Color
}

Register-ArgumentCompleter -CommandName Get-PDFConstantColor -ParameterName Color -ScriptBlock $Script:PDFColor