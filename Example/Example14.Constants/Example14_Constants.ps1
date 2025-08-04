Import-Module .\PSWritePDF.psd1 -Force

# Retrieve a specific action flag
$action = Get-PDFAction -Action SUBMIT_PDF
$action

# List all available action names
Get-PDFAction -All

# Retrieve a specific PDF version
$version = Get-PDFVersion -Version PDF_1_5
$version

# List all available PDF versions
Get-PDFVersion -All
