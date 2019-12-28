Import-Module .\PSWritePDF.psd1 -Force

New-PDF  -MarginLeft 520 { #520 -MarginRight 20 -MarginTop 20 -MarginBottom 20 -PageSize B4 -Rotate {
    New-PDFText -Text 'Test ', 'Me', 'Oooh' -FontColor BLUE, YELLOW, RED
    New-PDFList {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }
} -FilePath "$PSScriptRoot\Example01_MoreOptions.pdf" -Show

$Document = Get-PDF -FilePath "$PSScriptRoot\Example01_MoreOptions.pdf"
$Details = Get-PDFDetails -Document $Document
$Details | Format-List
$Details.Pages | Format-Table

Close-PDF -Document $Document