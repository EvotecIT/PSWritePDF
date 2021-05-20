function Set-PDFForm {
   [CmdletBinding()]
    param(
        [Parameter(Mandatory)]$SourceFilePath,
        [Parameter(Mandatory)]$DestinationFilePath,
        [System.Collections.IDictionary]$FieldNameAndValueHashTable,
        [Switch] $Flatten
    )

    if ((Test-Path -LiteralPath $SourceFilePath) -and (Test-Path -LiteralPath (Split-Path -LiteralPath  $DestinationFilePath))){
        $SourceFilePath = Convert-Path $SourceFilePath
        $DestinationFilePath = Convert-Path $DestinationFilePath
    
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
        
    <#
     .SYNOPSIS
    Will try to fill form fields in source PDF with values from hash table.
    Can also flatten the form to prevent changes with -flatten.

    .DESCRIPTION
    Adds a file name extension to a supplied name.
    Takes any strings for the file name or extension.

    .PARAMETER SourceFilePath
    Specifies the to be filled in PDF Form.

    .PARAMETER DestinationFilePath
    Specifies the output filepath for the completed form.

    .PARAMETER FieldNameAndValueHashTable
    Specifies the hashtable for the feild data. Key in the hashtable needs to match the feild name in the PDF.

    .PARAMETER Flatten
    Will flatten the output PDF so form feild will no longer be able to be changed. 
    #>
}
