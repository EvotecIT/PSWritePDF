Import-Module .\PSWritePDF.psd1 -Force

$output = Convert-HTMLToPDF -Uri 'https://evotec.xyz/hub/scripts/pswritehtml-powershell-module/' -OutputFilePath "$PSScriptRoot\Example10-FromURL.pdf" -Force -Open
Write-Host "PDF saved to $output"
