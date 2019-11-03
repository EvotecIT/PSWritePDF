# Validation for Actions
$Script:PDFAction = {
    ([iText.Kernel.Pdf.Action.PdfAction] | Get-Member -static -MemberType Property).Name
}
$Script:PDFActionValidation = {
    $Array = @(
        (& $Script:PDFAction)
        ''
    )
    $_ -in $Array
}

function Get-PDFConstantAction {
    [CmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFActionValidation } )][string] $Action
    )
    return [iText.Kernel.Pdf.Action.PdfAction]::$Action
}

Register-ArgumentCompleter -CommandName Get-PDFConstantAction -ParameterName Action -ScriptBlock $Script:PDFAction