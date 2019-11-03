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