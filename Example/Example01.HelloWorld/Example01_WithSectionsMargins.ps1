Import-Module .\PSWritePDF.psd1 -Force

New-PDF -MarginTop 200 {
    New-PDFPage -PageSize A5 {
        New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
        New-PDFText -Text 'Testing adding text. ', 'Keep in mind that this works like array.' -Font HELVETICA -FontColor RED
        New-PDFText -Text 'This text is going by defaults.', ' This will continue...', ' and we can continue working like that.'
        New-PDFList -Indent 3 {
            New-PDFListItem -Text 'Test'
            New-PDFListItem -Text '2nd'
        }
    }
    New-PDFPage -PageSize A4 -Rotate -MarginLeft 10 -MarginTop 50 {
        New-PDFText -Text 'Hello 1', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
        New-PDFText -Text 'Testing adding text. ', 'Keep in mind that this works like array.' -Font HELVETICA -FontColor RED
        New-PDFText -Text 'This text is going by defaults.', ' This will continue...', ' and we can continue working like that.'
        New-PDFList -Indent 3 {
            New-PDFListItem -Text 'Test'
            New-PDFListItem -Text '2nd'
        }
    }
} -FilePath "$PSScriptRoot\Example01_WithSectionsMargins.pdf" -Show

$Document = Get-PDF -FilePath "$PSScriptRoot\Example01_WithSections.pdf"
$Details = Get-PDFDetails -Document $Document
$Details | Format-List
$Details.Pages | Format-Table
Close-PDF -Document $Document