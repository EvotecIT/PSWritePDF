function Merge-PDF {
    <#
    .SYNOPSIS
    Merge PDF files into one.

    .DESCRIPTION
    Merge PDF files into one.

    .PARAMETER InputFile
    The PDF files to be merged.

    .PARAMETER OutputFile
    The output file path.

    .PARAMETER IgnoreProtection
    The switch will allow reading of PDF files that are "owner password" encrypted for protection/security (e.g. preventing copying of text, printing etc).
    The switch doesn't allow reading of PDF files that are "user password" encrypted (i.e. you cannot open them without the password)

    .EXAMPLE
    $FilePath1 = "$PSScriptRoot\Input\OutputDocument0.pdf"
    $FilePath2 = "$PSScriptRoot\Input\OutputDocument1.pdf"

    $OutputFile = "$PSScriptRoot\Output\OutputDocument.pdf" # Shouldn't exist / will be overwritten

    Merge-PDF -InputFile $FilePath1, $FilePath2 -OutputFile $OutputFile

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        [string[]] $InputFile,
        [string] $OutputFile,
        [switch] $IgnoreProtection
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
                $ResolvedFile = Convert-Path -LiteralPath $File
                try {
                    $Source = [iText.Kernel.Pdf.PdfReader]::new($ResolvedFile)
                    if ($IgnoreProtection) {
                        $null = $Source.SetUnethicalReading($true)
                    }
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