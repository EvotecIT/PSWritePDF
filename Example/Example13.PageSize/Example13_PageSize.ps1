Import-Module .\PSWritePDF.psd1 -Force

# Get single page size as iText object
$page = Get-PDFPageSize -PageSize A4
$page

# List all available page sizes
Get-PDFPageSize -All
