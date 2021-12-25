Import-Module .\PSWritePDF.psd1 -Force

Convert-HTMLToPDF -Uri 'https://evotec.xyz/hub/scripts/pswritehtml-powershell-module/' -OutputFilePath "$PSScriptRoot\Example10-FromURL.pdf" -Open