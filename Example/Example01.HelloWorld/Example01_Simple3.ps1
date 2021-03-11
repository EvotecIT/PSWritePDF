Import-Module .\PSWritePDF.psd1 -Force

# This shows handling of edge cases where this shouldnt throw errors, but warnings.

New-PDF -FilePath "$PSScriptRoot\Example01_Simple3-1.pdf" -PDFContent {
    Register-PDFFont -FontName 'Verdana' -FontPath 'C:\Windows\fonts\verdana.ttf' -Encoding IDENTITY_H -Cached -Default
    New-PDFText -Text 'Hello ', 'Привет !'
} -Show
New-PDF -FilePath "$PSScriptRoot\Example01_Simple3-2.pdf" -PDFContent {
    Register-PDFFont -FontName 'Verdana' -FontPath 'C:\Windows\fonts\verdana.ttf' -Encoding IDENTITY_H -Cached -Default
    New-PDFText -Text 'Hello ', 'Привет !'
} -Show

New-PDF -FilePath "$PSScriptRoot\Example01_Simple3-3.pdf" -PDFContent {

}

New-PDF -FilePath "D:\Example01_Simple2.pdf" -PDFContent { 'Test' }
