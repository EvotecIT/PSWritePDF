Describe 'New-PDFImage' {
    BeforeAll {
        New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output' | Out-Null
    }

    It 'returns image object for existing path' {
        $source = Join-Path $PSScriptRoot '..' 'Example' 'Example09.Images' 'Evotec-Logo-600x190.png'
        $imagePath = Join-Path $PSScriptRoot 'Input' 'TestImage.png'
        Copy-Item -Path $source -Destination $imagePath -Force

        $pdfPath = Join-Path $PSScriptRoot 'Output' 'ImageValid.pdf'
        { New-PDF { New-PDFImage -ImagePath $imagePath } -FilePath $pdfPath } | Should -Not -Throw
        Test-Path $pdfPath | Should -BeTrue

        Remove-Item -LiteralPath $imagePath -ErrorAction SilentlyContinue
    }

    It 'throws for missing image path' {
        $missingPath = Join-Path $PSScriptRoot 'Input' 'Missing.png'
        $pdfPath = Join-Path $PSScriptRoot 'Output' 'ImageMissing.pdf'

        { New-PDF { New-PDFImage -ImagePath $missingPath } -FilePath $pdfPath } | Should -Throw -ErrorId 'ImageNotFound,PSWritePDF.Cmdlets.CmdletNewPDFImage'
    }

    AfterAll {
        $folderPath = Join-Path $PSScriptRoot 'Output'
        Get-ChildItem -Path $folderPath -File | Remove-Item -ErrorAction SilentlyContinue
    }
}

