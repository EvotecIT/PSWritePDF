function Get-PDF {
    [CmdletBinding()]
    param(
        [string] $FilePath
    )

    if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
        $ResolvedPath = Convert-Path -LiteralPath $FilePath

        try {
            $PDFFile = [iText.Kernel.Pdf.PdfReader]::new($ResolvedPath)
            $Document = [iText.Kernel.Pdf.PdfDocument]::new($PDFFile)
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Get-PDF - Processing document $FilePath failed with error: $ErrorMessage"
        }
        $Document

    }
}