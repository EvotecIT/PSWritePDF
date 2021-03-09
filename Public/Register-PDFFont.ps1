function Register-PDFFont {
    [cmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $FontName,
        [Parameter(Mandatory)][string] $FontPath,
        [ValidateScript( { & $Script:PDFFontEncodingValidation } )][string] $Encoding,
        [switch] $Cached,
        [switch] $Default
    )
    try {
        if ($FontPath -and $Encoding) {
            $Script:Fonts[$FontName] = [iText.Kernel.Font.PdfFontFactory]::CreateFont($FontPath, [iText.IO.Font.PdfEncodings]::$Encoding, $Cached.IsPresent)
        } elseif ($FontPath) {
            $Script:Fonts[$FontName] = [iText.Kernel.Font.PdfFontFactory]::CreateFont($FontPath, $Cached.IsPresent)
        }
    } catch {
        Write-Warning "Register-PDFFont - Font registration failed. Error: $($_.Exception.Message)"
    }
    if (($Default -or $Script:Fonts.Count -eq 0) -and $Script:Fonts[$FontName]) {
        $Script:DefaultFont = $Script:Fonts[$FontName]
    }
}

$Script:Fonts = [ordered] @{}
# Validation for Fonts Encoding
$Script:PDFFontEncoding = {
    ([iText.IO.Font.PdfEncodings] | Get-Member -Static -MemberType Property).Name
}
$Script:PDFFontEncodingValidation = {
    $Array = @(
        (& $Script:PDFFontEncoding)
        ''
    )
    $_ -in $Array
}
Register-ArgumentCompleter -CommandName Register-PDFFont -ParameterName Encoding -ScriptBlock $Script:PDFFontEncoding