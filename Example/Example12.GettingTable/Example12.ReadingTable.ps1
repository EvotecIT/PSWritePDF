Import-Module .\PSWritePDF.psd1 -Force

$FilePath = "$PSSCriptRoot\Example12.ReadingTable.pdf"
$PDF = Get-PDF -FilePath $FilePath
$PDF

[iText.Layout.Canvas]

Close-PDF -Document $PDF