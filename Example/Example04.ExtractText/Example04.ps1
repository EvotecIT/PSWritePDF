Import-Module .\PSWritePDF.psd1 -Force

Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf"
