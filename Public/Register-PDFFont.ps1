function Register-PDFFont {
    [cmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $FontName,
        [Parameter(Mandatory)][string] $FontPath,
        [ValidateScript( { & $Script:PDFFontEncodingValidation } )][string] $Encoding,
        [iText.Kernel.Font.PdfFontFactory+EmbeddingStrategy] $EmbeddingStrategy = [iText.Kernel.Font.PdfFontFactory+EmbeddingStrategy]::PREFER_EMBEDDED,
        [switch] $Cached,
        [switch] $Default
    )
    if (Test-Path -LiteralPath $FontPath) {
        try {
            if ($FontPath -and $Encoding) {
                $Script:Fonts[$FontName] = [iText.Kernel.Font.PdfFontFactory]::CreateFont($FontPath, [iText.IO.Font.PdfEncodings]::$Encoding, $EmbeddingStrategy, $Cached.IsPresent)
            } elseif ($FontPath) {
                $Script:Fonts[$FontName] = [iText.Kernel.Font.PdfFontFactory]::CreateFont($FontPath, $EmbeddingStrategy)
            }
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw
            } else {
                Write-Warning "Register-PDFFont - Font registration failed. Error: $($_.Exception.Message)"
                return
            }
        }
        if (($Default -or $Script:Fonts.Count -eq 0) -and $Script:Fonts[$FontName]) {
            $Script:DefaultFont = $Script:Fonts[$FontName]
        }
    } else {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            throw "Font path '$FontPath' does not exist."
        } else {
            Write-Warning "Register-PDFFont - Font path does not exist. Path: $FontPath"
        }
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