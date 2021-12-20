Import-Module .\PSWritePDF.psd1 -Force

# Get all pages text
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf"

# Get page 1 text only
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -Page 1 -IgnoreProtection