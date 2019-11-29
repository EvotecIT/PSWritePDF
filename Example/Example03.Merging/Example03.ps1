#Import-Module .\PSWritePDF.psd1 -Force

$FilePath1 = "$PSScriptRoot\Input\OutputDocument0.pdf"
$FilePath2 = "$PSScriptRoot\Input\OutputDocument1.pdf"

$OutputFile = "$PSScriptRoot\Output\OutputDocument.pdf" # Shouldn't exist / will be overwritten

Merge-PDF -InputFile $FilePath1, $FilePath2 -OutputFile $OutputFile