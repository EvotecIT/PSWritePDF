function Get-PDFFormField {
    [CmdletBinding()]
    param(
        [iText.Kernel.Pdf.PdfDocument]$PDF
    )
    $PDFAcroForm = [iText.Forms.PdfAcroForm]::getAcroForm($PDF, $true)
    $PDFAcroForm.GetFormFields()
}