function Get-PDFFormField {
    [CmdletBinding()]
    param(
        [iText.Kernel.Pdf.PdfDocument]$PDF
    )
    try {
        $PDFAcroForm = [iText.Forms.PdfAcroForm]::getAcroForm($PDF, $true)
        $PDFAcroForm.GetFormFields()
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            Write-Error $_
            return
        } else {
            Write-Warning -Message "Get-PDFFormField - There was an error reading forms or no form exists. Exception: $($_.Error.Exception)"
        }
    }
}