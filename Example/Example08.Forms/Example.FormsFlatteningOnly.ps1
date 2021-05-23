Import-Module .\PSWritePDF.psd1 -Force

$FilePathSource = [IO.Path]::Combine("$PSScriptRoot", "Input", "SampleAcroForm.pdf")
#$FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "SampleAcroFormOutput.pdf")
$FilePath = ".\Example\Example08.Forms\Output\SampleAcroFormOutput.pdf"

Set-PDFForm -SourceFilePath $FilePathSource -DestinationFilePath $FilePath -Flatten