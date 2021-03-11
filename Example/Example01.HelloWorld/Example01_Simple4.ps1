Import-Module .\PSWritePDF.psd1 -Force

New-PDF -FilePath "D:\Example01_Simple4.1.pdf" -PDFContent { New-PDFText -Text 'Hello ', 'Привет !' } -Show
New-PDF -FilePath "D:\Example01_Simple4.2.pdf" -PDFContent {
    Register-PDFFont -FontName 'Verdana' -FontPath 'C:\Windows\fonts\verdana.ttf' -Encoding IDENTITY_H -Cached -Default
    New-PDFText -Text 'Hello ', 'Привет !'
} -Show