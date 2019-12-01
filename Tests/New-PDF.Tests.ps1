Describe 'New-PDF' {
    New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output'
    It 'New-PDF with default size should be A4 without rotation' {
        $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "PDF1.pdf")
        New-PDF {
            New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document
        Close-PDF -Document $Document

        $Page1 = $Details.Pages."1"
        $Page1.Size | Should -Be 'A4'
        $Page1.Rotated | Should -Be $false
        $Details.PagesNumber | Should -Be 1

    }
    It 'New-PDF with A4 and rotation should be created with proper size and rotation' {
        $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "PDF2.pdf")
        New-PDF  -MarginLeft 120 -MarginRight 20 -MarginTop 20 -MarginBottom 20 -PageSize A5 -Rotate {
            New-PDFText -Text 'Test ', 'Me', 'Oooh' -FontColor BLUE, YELLOW, RED
            New-PDFList -Indent 3 {
                New-PDFListItem -Text 'Test'
                New-PDFListItem -Text '2nd'
            }
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document
        Close-PDF -Document $Document


        $Page1 = $Details.Pages."1"
        $Page1.Size | Should -Be 'A5'
        $Page1.Rotated | Should -Be $true
        $Details.PagesNumber | Should -Be 1
    }
    It 'New-PDF with 4 pages. 1st A4 with rotation, 2nd A5 without rotation, 3rd A4 without rotation, 4th B2 with rotation' {
        $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "PDF3.pdf")
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
            New-PDFPage -PageSize A5 -Rotate {
                New-PDFText -Text 'Hello 1', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
            }
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document
        Close-PDF -Document $Document

        $Page1 = $Details.Pages."1"
        $Page1.Size | Should -Be 'A4'
        $Page1.Rotated | Should -Be $true

        $Page2 = $Details.Pages."2"
        $Page2.Size | Should -Be 'A5'
        $Page2.Rotated | Should -Be $false

        $Page3 = $Details.Pages."3"
        $Page3.Size | Should -Be 'A4'
        $Page3.Rotated | Should -Be $false

        $Page4 = $Details.Pages."4"
        $Page4.Size | Should -Be 'A5'
        $Page4.Rotated | Should -Be $true

        $Details.PagesNumber | Should -Be 4
    }
    It 'New-PDF with 2 pages. A4 and A5 rotated' {
        $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "PDF4.pdf")
        New-PDF -PageSize A5 {
            New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true

            New-PDFPage -PageSize A4 -Rotate {
                New-PDFText -Text 'Hello 1', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
            }
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document
        Close-PDF -Document $Document

        $Page1 = $Details.Pages."1"
        $Page1.Size | Should -Be 'A5'
        $Page1.Rotated | Should -Be $false

        $Page2 = $Details.Pages."2"
        $Page2.Size | Should -Be 'A4'
        $Page2.Rotated | Should -Be $true
        $Details.PagesNumber | Should -Be 2
    }

    # cleanup
    $FolderPath = [IO.Path]::Combine("$PSScriptRoot", "Output")
    $Files = Get-ChildItem -LiteralPath $FolderPath -File
    foreach ($_ in $Files) {
        Remove-Item -LiteralPath $_.FullName -ErrorAction SilentlyContinue
    }
}