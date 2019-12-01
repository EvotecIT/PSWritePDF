Import-Module .\PSWritePDF.psd1 -Force

$Document = Get-PDF -FilePath "C:\Users\przemyslaw.klys\OneDrive - Evotec\Support\GitHub\PSWritePDF\Example\Example01.HelloWorld\Example01_WithSectionsMix.pdf"
$Details = Get-PDFDetails -Document $Document
$Details | Format-List
$Details.Pages | Format-Table

Close-PDF -Document $Document