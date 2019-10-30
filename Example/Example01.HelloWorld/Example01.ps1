Import-Module .\PSWritePDF.psd1 -Force

New-PDF {
    New-PDFText -Text 'Test ', 'Me', 'Oooh'
    New-PDFList -Indent 12 {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }
} -FilePath "$PSScriptRoot\Test.pdf" #-Show
