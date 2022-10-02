Import-Module .\PSWritePDF.psd1 -Force

# Get all pages text
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf"

Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -ExtractionStrategy LocationTextExtractionStrategy

Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -ExtractionStrategy SimpleTextExtractionStrategy

# Get page 1 text only
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -Page 1 -IgnoreProtection