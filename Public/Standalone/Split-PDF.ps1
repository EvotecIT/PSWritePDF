function Split-PDF {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $FilePath,
        [Parameter(Mandatory)][string] $OutputFolder,
        [string] $OutputName = 'OutputDocument',
        [int] $SplitCount = 1
    )
    if ($SplitCount -eq 0) {
        Write-Warning "Split-PDF - SplitCount is 0. Terminating."
        return
    }

    if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
        $ResolvedPath = Convert-Path -LiteralPath $FilePath
        if ($OutputFolder -and (Test-Path -LiteralPath $OutputFolder)) {
            try {
                $PDFFile = [iText.Kernel.Pdf.PdfReader]::new($ResolvedPath)
                $Document = [iText.Kernel.Pdf.PdfDocument]::new($PDFFile)
                $Splitter = [CustomSplitter]::new($Document, $OutputFolder, $OutputName)
                $List = $Splitter.SplitByPageCount($SplitCount)
                foreach ($_ in $List) {
                    $_.Close()
                }
            } catch {
                $ErrorMessage = $_.Exception.Message
                Write-Warning "Split-PDF - Error has occured: $ErrorMessage"
            }
            try {
                $PDFFile.Close()
            } catch {
                $ErrorMessage = $_.Exception.Message
                Write-Warning "Split-PDF - Closing document $FilePath failed with error: $ErrorMessage"
            }
        } else {
            Write-Warning "Split-PDF - Destination folder $OutputFolder doesn't exists. Terminating."
        }
    } else {
        Write-Warning "Split-PDF - Path $FilePath doesn't exists. Terminating."
    }
}