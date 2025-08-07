Import-Module .\PSWritePDF.psd1 -Force

# Get all pages text as objects
$pages = Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf"
$pages | Format-Table -AutoSize

# Save combined text to file
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -OutFile "$PSScriptRoot\Example04.txt"

# Use different extraction strategies
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -ExtractionStrategy LocationTextExtractionStrategy
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -ExtractionStrategy SimpleTextExtractionStrategy

# Get page 1 text only
Convert-PDFToText -FilePath "$PSScriptRoot\Example04.pdf" -Page 1 -IgnoreProtection

