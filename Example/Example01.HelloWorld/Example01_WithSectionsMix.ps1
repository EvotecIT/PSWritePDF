#Import-Module .\PSWritePDF.psd1 -Force

New-PDF -PageSize A4 -Rotate {
    New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
    New-PDFText -Text 'Testing adding text. ', 'Keep in mind that this works like array.' -Font HELVETICA -FontColor RED
    New-PDFText -Text 'This text is going by defaults.', ' This will continue...', ' and we can continue working like that.'
    New-PDFList -Indent 3 {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }

    New-PDFPage -PageSize A5 {
        New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
        New-PDFText -Text 'Testing adding text. ', 'Keep in mind that this works like array.' -Font HELVETICA -FontColor RED
        New-PDFText -Text 'This text is going by defaults.', ' This will continue...', ' and we can continue working like that.'
        New-PDFList -Indent 3 {
            New-PDFListItem -Text 'Test'
            New-PDFListItem -Text '2nd'
        }
    }

} -FilePath "$PSScriptRoot\Example01_WithSectionsMix.pdf" -Show