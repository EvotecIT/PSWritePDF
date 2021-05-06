Import-Module .\PSWritePDF.psd1 -Force

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

Set-PDFForm -SourceFilePath $FilePathSource -DestinationFilePath $FilePath -FieldNameAndValueHashTable $FieldNameAndValueHashTable

# Reading PDF forms
$PDF = Get-PDF -FilePath $FilePath
$AcrobatFormFields = Get-PDFFormField -PDF $PDF
$AcrobatFormFields | Format-Table
Close-PDF -Document $PDF