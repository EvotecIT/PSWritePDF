Import-Module .\PSWritePDF.psd1 -Force

New-PDF -PageSize B4 -Rotate -FilePath "$PSScriptRoot\Example01_MoreOptions.pdf" -Show {
    New-PDFOptions -MarginLeft 520 -MarginRight 20 -MarginTop 20 -MarginBottom 20 -PassThru | Out-Null
    New-PDFText -Text 'Test ', 'Me', 'Oooh' -FontColor BLUE, YELLOW, RED
    New-PDFList {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }
}

$Document = Get-PDF -FilePath "$PSScriptRoot\Example01_MoreOptions.pdf"
$Details = Get-PDFDetails -Document $Document
$Details | Format-List
$Details.Pages | Format-Table

Close-PDF -Document $Document
