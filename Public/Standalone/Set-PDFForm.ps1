function Set-PDFForm {
    [CmdletBinding()]
    param(
        [string] $SourceFilePath,
        [string] $DestinationFilePath,
        [System.Collections.IDictionary]$FieldNameAndValueHashTable,
        [Switch] $Flatten
    )

    $Script:Reader = [iText.Kernel.Pdf.PdfReader]::new($SourceFilePath)
    $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($DestinationFilePath)
    $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Script:Reader, $Script:Writer)

    $PDFAcroForm = [iText.Forms.PdfAcroForm]::getAcroForm($PDF, $true)
    foreach ($Key in $FieldNameAndValueHashTable.Keys) {
        $FormField = $PDFAcroForm.getField($Key)
        if ( -not $FormField) { 
            Write-Warning "No form field with name $Key found" 
            continue
        }
        
        if ($FormField.GetType().Name -match "Button") {
            $FormField.setValue(
                $FormField.GetAppearanceStates()[
                    [Int]$FieldNameAndValueHashTable[$Key]
                ]
            ) | Out-Null
        } else {
            $FormField.setValue($FieldNameAndValueHashTable[$Key]) | Out-Null
        }
    }
    
    if($Flatten)
    {
        $PDFAcroForm.flattenFields()
    }
    
    $PDF.Close()
}
