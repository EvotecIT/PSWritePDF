# Validation for PageSize
$Script:PDFPageSize = {
    ([iText.Kernel.Geom.PageSize] | Get-Member -static -MemberType Property).Name
}
$Script:PDFPageSizeValidation = {
    # Empty element is added to allow no parameter value
    $Array = @(
        (& $Script:PDFPageSize)
        ''
    )
    $_ -in $Array
}

function Get-PDFConstantPageSize {
    [CmdletBinding()]
    param(
        [ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize,
        [switch] $All
    )
    if (-not $All) {
        return [iText.Kernel.Geom.PageSize]::$PageSize
    } else {
        return & $Script:PDFPageSize
    }
}

Register-ArgumentCompleter -CommandName Get-PDFConstantPageSize  -ParameterName Version -ScriptBlock $Script:PDFPageSize