function Set-PDFForm {
   [CmdletBinding()]
    param(
        [Parameter(Mandatory)]$SourceFilePath,
        [Parameter(Mandatory)]$DestinationFilePath,
        [System.Collections.IDictionary]$FieldNameAndValueHashTable,
        [Switch] $Flatten
    )
    
    $SourceFilePath = Convert-Path $SourceFilePath
    $DestinationFilePath = Convert-Path $DestinationFilePath

    if ((Test-Path -LiteralPath $SourceFilePath) -and (Test-Path -LiteralPath (Split-Path -LiteralPath  $DestinationFilePath))){
        try{
        $Script:Reader = [iText.Kernel.Pdf.PdfReader]::new($SourceFilePath)
        $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($DestinationFilePath)
        $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Script:Reader, $Script:Writer)
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Set-PDFForm - Error has occured: $ErrorMessage"
        }

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

        try{
        $PDF.Close()
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Set-PDFForm - Error has occured: $ErrorMessage"
        }
    }
    else {
        if(-not (Test-Path -LiteralPath $SourceFilePath)){
            Write-Warning "Set-PDFForm - Path $SourceFilePath doesn't exists. Terminating."
            }

         if(-not (Test-Path -LiteralPath (Split-Path -LiteralPath  $DestinationFilePath))){
            Write-Warning "Set-PDFForm - Path $DestinationFilePath doesn't exists. Terminating."
            }
        }

}
