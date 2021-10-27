function Merge-PDF {
    <#
    .SYNOPSIS
    This function Will try and merge PDFs into a single PDF document.

    .DESCRIPTION
    This function Will try and merge PDFs into a single PDF document.

    .PARAMETER InputFile
    This is an array of PDF files to be merged or a file list seperated by commas and quoted.

    .PARAMETER OutputFile
    Provide the full path to the file for ouptut including name of the file.

    .PARAMETER SetUnethicalReading
    Will allow reading from password protected PDFs without the password 
    
    CAUTION: This will potentially combine protected files with unprotected files 
    and end with an unprotcetd file.
    
    .EXAMPLE
     >Merge-PDF -InputFile "file1.pdf", "file2.pdf" -OutputFile c:\full\path\to\file.pdf

    .EXAMPLE
     >Merge-PDF -InputFile $(gci *.pdf).FullName -OutputFile c:\full\path\to\file.pdf

    #>
    [CmdletBinding()]
    param(
        [string[]] $InputFile,
        [string] $OutputFile,
        [switch] $SetUnethicalReading
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
                    $Source.SetUnethicalReading($SetUnethicalReading) | Out-Null
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