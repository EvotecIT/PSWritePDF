Import-Module .\PSWritePDF.psd1 -Force

New-PDF  -MarginLeft 120 -MarginRight 20 -MarginTop 20 -MarginBottom 20 -PageSize B2 -Rotate {
    New-PDFText -Text 'Test ', 'Me', 'Oooh' -FontColor BLUE
    New-PDFList -Indent 3 {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }
} -FilePath "$PSScriptRoot\Example01_MoreOptions.pdf" -Show