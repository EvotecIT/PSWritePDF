Import-Module .\PSWritePDF.psd1 -Force

$FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "SampleAcroFormOutput.pdf")
$FilePathSource = [IO.Path]::Combine("$PSScriptRoot", "Input", "SampleAcroForm.pdf")

$PDF = @{ "Text 1" = "Pipeline Example" } |
    Set-PDFForm -SourceFilePath $FilePathSource -DestinationFilePath $FilePath -PassThru |
    Get-PDF

Get-PDFFormField -PDF $PDF | Format-Table
Close-PDF -Document $PDF
