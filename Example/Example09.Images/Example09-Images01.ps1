Import-Module .\PSWritePDF.psd1 -Force

New-PDF -MarginLeft 20 { #520 -MarginRight 20 -MarginTop 20 -MarginBottom 20 -PageSize B4 -Rotate {
    New-PDFImage -ImagePath "$PSScriptRoot\Evotec-Logo-600x190.png" -BackgroundColor Red -BackgroundColorOpacity 0.5
    New-PDFImage -ImagePath "$PSScriptRoot\Evotec-Logo-600x190.png"
    New-PDFText -Text 'Test ', 'Me', 'Oooh' -FontColor BLUE, YELLOW, RED
    New-PDFList {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }
} -FilePath "$PSScriptRoot\Example09-Images01.pdf" -Show