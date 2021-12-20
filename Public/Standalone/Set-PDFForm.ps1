function Set-PDFForm {
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
    Specifies the hashtable for the fields data. Key in the hashtable needs to match the feild name in the PDF.

    .PARAMETER Flatten
    Will flatten the output PDF so form fields will no longer be able to be changed.

    .PARAMETER IgnoreProtection
    The switch will allow reading of PDF files that are "owner password" encrypted for protection/security (e.g. preventing copying of text, printing etc).
    The switch doesn't allow reading of PDF files that are "user password" encrypted (i.e. you cannot open them without the password)

    .EXAMPLE
    $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "SampleAcroFormOutput.pdf")
    $FilePathSource = [IO.Path]::Combine("$PSScriptRoot", "Input", "SampleAcroForm.pdf")

    $FieldNameAndValueHashTable = [ordered] @{
        "Text 1" = "Text 1 input"
        "Text 2" = "Text 2 input"
        "Text 3" = "Text 3 input"
        "Check Box 1 True" = $true
        "Check Box 2 False" = $false
        "Check Box 3 False" = $false
        "Check Box 4 True" = $true
        "Doesn't Exist" = "will not be used"
    }
    Set-PDFForm -SourceFilePath $FilePathSource -DestinationFilePath $FilePath -FieldNameAndValueHashTable $FieldNameAndValueHashTable -Flatten

    .EXAMPLE
    $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "SampleAcroFormOutput.pdf")
    $FilePathSource = [IO.Path]::Combine("$PSScriptRoot", "Input", "SampleAcroForm.pdf")
    Set-PDFForm -SourceFilePath $FilePathSource -DestinationFilePath $FilePath -Flatten

    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()] $SourceFilePath,
        [Parameter(Mandatory)][ValidateNotNullOrEmpty()] $DestinationFilePath,
        [System.Collections.IDictionary] $FieldNameAndValueHashTable,
        [alias('FlattenFields')][Switch] $Flatten,
        [switch] $IgnoreProtection
    )
    $SourceFilePath = Convert-Path -LiteralPath $SourceFilePath
    $DestinationFolder = Split-Path -LiteralPath $DestinationFilePath
    $DestinationFolderPath = Convert-Path -LiteralPath $DestinationFolder -ErrorAction SilentlyContinue

    if ($DestinationFolderPath -and (Test-Path -LiteralPath $SourceFilePath) -and (Test-Path -LiteralPath $DestinationFolderPath)) {
        $File = Split-Path -Path $DestinationFilePath -Leaf
        $DestinationFilePath = Join-Path -Path $DestinationFolderPath -ChildPath $File

        try {
            $Script:Reader = [iText.Kernel.Pdf.PdfReader]::new($SourceFilePath)
            if ($IgnoreProtection) {
                $null = $Script:Reader.SetUnethicalReading($true)
            }
            $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($DestinationFilePath)
            $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Script:Reader, $Script:Writer)
            $PDFAcroForm = [iText.Forms.PdfAcroForm]::getAcroForm($PDF, $true)
        } catch {
            Write-Warning "Set-PDFForm - Error has occured: $($_.Exception.Message)"
        }
        foreach ($Key in $FieldNameAndValueHashTable.Keys) {
            $FormField = $PDFAcroForm.getField($Key)
            if ( -not $FormField) {
                Write-Warning "Set-PDFForm - No form field with name '$Key' found"
                continue
            }

            if ($FormField.GetType().Name -match "Button") {
                $null = $FormField.setValue(
                    $FormField.GetAppearanceStates()[[Int]$FieldNameAndValueHashTable[$Key]]
                )
            } else {
                $null = $FormField.setValue($FieldNameAndValueHashTable[$Key])
            }
        }

        if ($Flatten) {
            $PDFAcroForm.flattenFields()
        }

        try {
            $PDF.Close()
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error $_
                return
            } else {
                $ErrorMessage = $_.Exception.Message
                Write-Warning "Set-PDFForm - Error has occured: $ErrorMessage"
            }
        }
    } else {
        if (-not (Test-Path -LiteralPath $SourceFilePath)) {
            Write-Warning "Set-PDFForm - Path $SourceFilePath doesn't exists. Terminating."
        }

        if (-not (Test-Path -LiteralPath $DestinationFolder)) {
            Write-Warning "Set-PDFForm - Folder $DestinationFolder doesn't exists. Terminating."
        }
    }
}
