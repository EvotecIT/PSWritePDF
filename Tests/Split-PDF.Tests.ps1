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
        Split-PDF -FilePath $file -OutputFolder $output -SplitCount 1 -OutputName 'part'
        (Get-ChildItem -Path $output -Filter 'part*.pdf').Count | Should -BeGreaterThan 1
    }

    It 'splits pdf by page ranges' {
        $output = Join-Path $PSScriptRoot 'Output' 'Ranges'
        New-Item -Path $output -Force -ItemType Directory | Out-Null
        $file = Join-Path $PSScriptRoot 'Input' 'SampleToSplit.pdf'
        Split-PDF -FilePath $file -OutputFolder $output -PageRange '1'
        (Get-ChildItem -Path $output -Filter 'OutputDocument*.pdf').Count | Should -Be 1
    }

    It 'splits pdf by bookmarks' {
        $output = Join-Path $PSScriptRoot 'Output' 'Bookmarks'
        New-Item -Path $output -Force -ItemType Directory | Out-Null
        $file = Join-Path $PSScriptRoot 'Input' 'Bookmarked.pdf'
        Split-PDF -FilePath $file -OutputFolder $output -Bookmark 'Chapter 1','Chapter 2'
        (Get-ChildItem -Path $output -Filter 'OutputDocument*.pdf').Count | Should -Be 2
    }

    AfterAll {
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Input' 'Bookmarked.pdf') -Force
        Remove-Item -LiteralPath (Join-Path $PSScriptRoot 'Output') -Recurse -Force
    }
}
