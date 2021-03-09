# Validation for Fonts
$Script:PDFFont = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    ([iText.IO.Font.Constants.StandardFonts] | Get-Member -Static -MemberType Property).Name | Where-Object { $_ -like "*$wordToComplete*" }
}
$Script:PDFFontValidation = {
    $Array = @(
        (& $Script:PDFFont)
        ''
    )
    $_ -in $Array
}
$Script:PDFFontList = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    @(
        ([iText.IO.Font.Constants.StandardFonts] | Get-Member -Static -MemberType Property).Name
        if ($Script:Fonts.Keys) { $Script:Fonts.Keys }
    ) | Where-Object { $_ -like "*$wordToComplete*" }
}
$Script:PDFFontValidationList = {
    $Array = @(
        (& $Script:PDFFont)
        $Script:Fonts.Keys
        ''
    )
    $_ -in $Array
}