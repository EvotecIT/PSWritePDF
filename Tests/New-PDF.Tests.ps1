Import-Module .\PSWritePDF.psd1 -Force

Describe 'New-PDF' {
    It 'New-PDF with default size should be A4 without rotation' {
        $FilePath = "$PSScriptRoot\Output\PDF1.pdf"
        New-PDF {
            New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document
        $Page1 = $Details.Pages."1"
        $Page1.Width | Should -Be 595
        $Page1.Height | Should -Be 842
        $Details.PagesNumber | Should -Be 1
        Close-PDF -Document $Document
    }
    It 'New-PDF with A4 and rotation should be created with proper size and rotation' {
        $FilePath = "$PSScriptRoot\Output\PDF2.pdf"
        New-PDF  -MarginLeft 120 -MarginRight 20 -MarginTop 20 -MarginBottom 20 -PageSize A4 -Rotate {
            New-PDFText -Text 'Test ', 'Me', 'Oooh' -FontColor BLUE, YELLOW, RED
            New-PDFList -Indent 3 {
                New-PDFListItem -Text 'Test'
                New-PDFListItem -Text '2nd'
            }
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document
        $Page1 = $Details.Pages."1"
        $Page1.Height | Should -Be 595
        $Page1.Width | Should -Be 842
        $Details.PagesNumber | Should -Be 1
        Close-PDF -Document $Document
    }
    It 'New-PDF with 4 pages. 1st A4 with rotation, 2nd A5 without rotation, 3rd A4 without rotation, 4th B2 with rotation' {
        $FilePath = "$PSScriptRoot\Output\PDF3.pdf"
        New-PDF {
            New-PDFPage -PageSize A4 -Rotate {
                New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
            }
            New-PDFPage -PageSize A5 {
                New-PDFText -Text 'Hello 1', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
            }
            New-PDFPage -PageSize A4 {
                New-PDFText -Text 'Hello 1', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
            }
            New-PDFPage -PageSize B2 -Rotate {
                New-PDFText -Text 'Hello 1', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
            }
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document
        $Page1 = $Details.Pages."1"
        $Page1.Height | Should -Be 595
        $Page1.Width | Should -Be 842

        $Page2 = $Details.Pages."2"
        $Page2.Height | Should -Be 595
        $Page2.Width | Should -Be 420

        $Page3 = $Details.Pages."3"
        $Page3.Height | Should -Be 842
        $Page3.Width | Should -Be 595

        $Page4 = $Details.Pages."4"
        $Page4.Height | Should -Be 595
        $Page4.Width | Should -Be 842

        $Details.PagesNumber | Should -Be 4
        Close-PDF -Document $Document

    }
    It 'Given2' {
        $FilePath = "$PSScriptRoot\Output\PDF4.pdf"
        New-PDF {
            New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true

            New-PDFPage -PageSize A4 -Rotate {
                New-PDFText -Text 'Hello 1', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
            }
        } -FilePath $FilePath
    }
    $Files = Get-ChildItem -LiteralPath "$PSScriptRoot\Output" -File
    foreach ($_ in $Files) {
        Remove-Item -LiteralPath $_.FullName
    }
}