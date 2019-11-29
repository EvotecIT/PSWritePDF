function Merge-PDF {
    [CmdletBinding()]
    param(
        [string[]] $InputFile,
        [string] $OutputFile
    )

    if ($OutputFile) {
        try {
            [iText.Kernel.Pdf.PdfWriter] $Writer = [iText.Kernel.Pdf.PdfWriter]::new($OutputFile)
            [iText.Kernel.Pdf.PdfDocument] $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Writer);
            [iText.Kernel.Utils.PdfMerger] $Merger = [iText.Kernel.Utils.PdfMerger]::new($PDF)
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Merge-PDF - Processing document $OutputFile failed with error: $ErrorMessage"
        }
        foreach ($File in $InputFile) {
            if ($File -and (Test-Path -LiteralPath $File)) {
                $ResolvedFile = Resolve-Path -LiteralPath $File
                try {
                    $Source = [iText.Kernel.Pdf.PdfReader]::new($ResolvedFile)
                    [iText.Kernel.Pdf.PdfDocument] $SourcePDF = [iText.Kernel.Pdf.PdfDocument]::new($Source);
                    $null = $Merger.merge($SourcePDF, 1, $SourcePDF.getNumberOfPages())
                    $SourcePDF.close()
                } catch {
                    $ErrorMessage = $_.Exception.Message
                    Write-Warning "Merge-PDF - Processing document $ResolvedFile failed with error: $ErrorMessage"
                }
            }
        }
        try {
            $PDF.Close()
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Merge-PDF - Saving document $OutputFile failed with error: $ErrorMessage"
        }
    } else {
        Write-Warning "Merge-PDF - Output file was empty. Please give a name to file. Terminating."
    }
}