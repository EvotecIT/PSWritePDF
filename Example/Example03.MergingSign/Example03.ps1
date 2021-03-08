Import-Module .\PSWritePDF.psd1 -Force

$FilePath = Get-ChildItem -Path $PSScriptRoot\Input -Filter *.pdf
$OutputFile = "$PSScriptRoot\Output\OutputDocument.pdf" # Shouldn't exist / will be overwritten

Merge-PDF -InputFile $FilePath.FullName -OutputFile $OutputFile