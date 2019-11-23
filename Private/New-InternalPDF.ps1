function New-InternalPDF {
    [CmdletBinding()]
    param(
        [string] $FilePath
    )
    try {
        $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($FilePath)
    } catch {
        if ($_.Exception.Message -like '*The process cannot access the file*because it is being used by another process.*') {
            Write-Warning "New-InternalPDF - File $FilePath is in use. Terminating."
            Exit
        } else {
            Write-Warning "New-InternalPDF - Terminating error: $($_.Exception.Message)"
            Exit
        }
    }
    if ($Script:Writer) {
        $Script:PDF = [iText.Kernel.Pdf.PdfDocument]::new($Script:Writer)
    } else {
        Write-Warning "New-InternalPDF - Terminating as writer doesn't exists."
        Exit
    }
}