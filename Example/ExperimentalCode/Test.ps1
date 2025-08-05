Import-Module .\PSWritePDF.psd1 -Force

New-PDF -FilePath "$PSScriptRoot\Example01_Simple3-2.pdf" -PDFContent {
    Register-PDFFont -FontName 'JavaText' -FontPath 'C:\Windows\fonts\javatext.ttf' -Encoding IdentityH -Cached -Default
    New-PDFText -Text 'Hello ', 'Привет !'
} -Show