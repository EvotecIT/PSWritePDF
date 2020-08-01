
Describe 'New-PDF' {
    New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output'
    It 'New-PDFTable should not throw when using 2 element array' {
        $Data = @(
            [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
            [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
        )

        $FilePath = [IO.Path]::Combine("$PSScriptRoot", 'Output', 'PDFTable1.pdf')
        New-PDF {
            New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true

            New-PDFTable -DataTable $Data
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document

        Close-PDF -Document $Document

        $Page1 = $Details.Pages.'1'
        $Page1.Size | Should -Be 'A4'
        $Page1.Rotated | Should -Be $false
        $Details.PagesNumber | Should -Be 1
    }
    It 'New-PDFTable should not throw when using 1 element array' {
        $Data = @(
            [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
        )

        $FilePath = [IO.Path]::Combine("$PSScriptRoot", 'Output', 'PDFTable2.pdf')
        New-PDF {
            New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true

            New-PDFTable -DataTable $Data
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document

        Close-PDF -Document $Document

        $Page1 = $Details.Pages.'1'
        $Page1.Size | Should -Be 'A4'
        $Page1.Rotated | Should -Be $false
        $Details.PagesNumber | Should -Be 1
    }
    It 'New-PDFTable should not throw when using multiple tables' {
        $Data1 = @(
            [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
        )
        $Data2 = @(
            [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
            [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
        )
        $Data3 = @(
            @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
            @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
        )
        $Data4 = @(
            [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
            [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
            [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
        )
        $Data5 = @(
            [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
        )
        $Data6 = [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }

        $FilePath = [IO.Path]::Combine("$PSScriptRoot", 'Output', 'PDFTable3.pdf')
        New-PDF {
            New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true

            New-PDFTable -DataTable $Data1
            New-PDFTable -DataTable $Data2
            New-PDFTable -DataTable $Data3
            New-PDFTable -DataTable $Data4
            New-PDFTable -DataTable $Data5
            New-PDFTable -DataTable $Data6
        } -FilePath $FilePath

        $Document = Get-PDF -FilePath $FilePath
        $Details = Get-PDFDetails -Document $Document

        Close-PDF -Document $Document

        $Page1 = $Details.Pages.'1'
        $Page1.Size | Should -Be 'A4'
        $Page1.Rotated | Should -Be $false
        $Details.PagesNumber | Should -Be 1
    }
}