Describe 'Split-PDF' {
    BeforeAll {
        $OutputRoot = Join-Path $PSScriptRoot 'Output'
        New-Item -Path $OutputRoot -Force -ItemType Directory | Out-Null

        $BookmarkedFile = Join-Path $PSScriptRoot 'Input' 'Bookmarked.pdf'
        $writer = [iText.Kernel.Pdf.PdfWriter]::new($BookmarkedFile)
        $pdf = [iText.Kernel.Pdf.PdfDocument]::new($writer)
        $document = [iText.Layout.Document]::new($pdf)
        $document.Add([iText.Layout.Element.Paragraph]::new('Chapter 1'))
        $document.Add([iText.Layout.Element.AreaBreak]::new())
        $document.Add([iText.Layout.Element.Paragraph]::new('Chapter 2'))

        $root = $pdf.GetOutlines($true)
        $root.AddOutline('Chapter 1').AddDestination([iText.Kernel.Pdf.Navigation.PdfExplicitDestination]::CreateFit($pdf.GetPage(1)))
        $root.AddOutline('Chapter 2').AddDestination([iText.Kernel.Pdf.Navigation.PdfExplicitDestination]::CreateFit($pdf.GetPage(2)))

        $document.Close()
    }

    It 'splits pdf into parts' {
        $output = Join-Path $PSScriptRoot 'Output' 'Parts'
        New-Item -Path $output -Force -ItemType Directory | Out-Null
        $file = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        $files = Split-PDF -FilePath $file -OutputFolder $output -SplitCount 1 -OutputName 'part'
        $files.Count | Should -BeGreaterThan 1
        $files | ForEach-Object { Test-Path $_ | Should -BeTrue }
    }

    It 'splits pdf by page ranges' {
        $output = Join-Path $PSScriptRoot 'Output' 'Ranges'
        New-Item -Path $output -Force -ItemType Directory | Out-Null
        $file = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        $files = Split-PDF -FilePath $file -OutputFolder $output -PageRange '1'
        $files.Count | Should -Be 1
        $files | ForEach-Object { Test-Path $_ | Should -BeTrue }
    }

    It 'splits pdf by bookmarks' {
        $output = Join-Path $PSScriptRoot 'Output' 'Bookmarks'
        New-Item -Path $output -Force -ItemType Directory | Out-Null
        $file = Join-Path $PSScriptRoot 'Input' 'Bookmarked.pdf'
        $files = Split-PDF -FilePath $file -OutputFolder $output -Bookmark 'Chapter 1','Chapter 2'
        $files.Count | Should -Be 2
        $files | ForEach-Object { Test-Path $_ | Should -BeTrue }
    }

    It 'performs a dry run with WhatIf' {
        $output = Join-Path $PSScriptRoot 'Output' 'DryRun'
        New-Item -Path $output -Force -ItemType Directory | Out-Null
        $file = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        $files = Split-PDF -FilePath $file -OutputFolder $output -SplitCount 1 -WhatIf
        (Get-ChildItem -Path $output -Filter '*.pdf').Count | Should -Be 0
        $files | Should -BeNullOrEmpty
    }

    It 'overwrites existing files with Force' {
        $output = Join-Path $PSScriptRoot 'Output' 'Force'
        New-Item -Path $output -Force -ItemType Directory | Out-Null
        $file = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        $first = Split-PDF -FilePath $file -OutputFolder $output -SplitCount 1 -OutputName 'part'
        $second = Split-PDF -FilePath $file -OutputFolder $output -SplitCount 1 -OutputName 'part'
        $second | Should -BeNullOrEmpty
        $forced = Split-PDF -FilePath $file -OutputFolder $output -SplitCount 1 -OutputName 'part' -Force
        $forced.Count | Should -BeGreaterThan 0
    }

    AfterAll {
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Input' 'Bookmarked.pdf') -Force
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Output') -Recurse -Force
    }
}
