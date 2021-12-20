Import-Module .\PSWritePDF.psd1 -Force

Convert-HTMLToPDF -Uri 'https://en.wikipedia.org/wiki/PowerShell' -OutputFilePath "$PSScriptRoot\Example10-FromURL.pdf" -Open