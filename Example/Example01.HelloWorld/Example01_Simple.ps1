Import-Module .\PSWritePDF.psd1 -Force

New-PDF {
    Register-PDFFont -FontName 'Verdana' -FontPath 'C:\Windows\fonts\verdana.ttf' -Encoding IDENTITY_H -Cached -Default
    New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
    New-PDFText -Text 'Testing adding text. ', 'Keep in mind that this works like array.' -Font HELVETICA -FontColor RED
    New-PDFText -Text 'This text is going by defaults.', ' This will continue...', ' and we can continue working like that.'
    New-PDFList -Indent 3 {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }

    New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
    New-PDFText -Text 'Testing adding text. ', 'Keep in mind that this works like array.' -Font HELVETICA -FontColor RED
    New-PDFText -Text 'This text is going by defaults.', ' This will continue...', ' and we can continue working like that.'
    New-PDFText -Text 'Following text written in polish with default font Verdana that we set in the beggining: '
    New-PDFText -Text 'Polski tekst ma się dobrze, tak dobrze, że aż za dobrze'
    New-PDFText -Text 'łomatko' -Font 'HELVETICA'
    New-PDFList -Indent 3 {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
        New-PDFListItem -Text 'ąłęć - unicode with Verdana must work', ' and bold' -FontBold $null, $true -Font Verdana, HELVETICA -FontColor GRAY, BLUE
        New-PDFListItem -Text 'ąłęć - must work', ' and bold'
    }
} -FilePath "$PSScriptRoot\Example01_Simple.pdf" -Show