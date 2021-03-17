function Set-PDFForm {
    [CmdletBinding()]
    param(
        [string] $SourceFilePath,
        [string] $DestinationFilePath,
        [System.Collections.IDictionary]$FieldNameAndValueHashTable
    )

    $Script:Reader = [iText.Kernel.Pdf.PdfReader]::new($SourceFilePath)
    $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($DestinationFilePath)
    $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Script:Reader, $Script:Writer)

    $PDFAcroForm = [iText.Forms.PdfAcroForm]::getAcroForm($PDF, $true)
    foreach ($Key in $FieldNameAndValueHashTable.Keys) {
        $null = $PDFAcroForm.getField($Key).setValue($FieldNameAndValueHashTable[$Key])
    }
    $PDF.Close()
}