Describe 'New-PDFImage' {
    BeforeAll {
        New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output' | Out-Null
    }

    It 'returns image object for existing path' {
        $imagePath = Join-Path $PSScriptRoot 'Input' 'TestImage.png'
        [IO.File]::WriteAllBytes($imagePath, [Convert]::FromBase64String('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGMAAAoAAQUBAO9pAAAAAElFTkSuQmCC'))

        $pdfPath = Join-Path $PSScriptRoot 'Output' 'ImageValid.pdf'
        $image = New-PDF {
            New-PDFImage -ImagePath $imagePath
        } -FilePath $pdfPath

        $image | Should -BeOfType 'iText.Layout.Element.Image'

        Remove-Item -LiteralPath $imagePath -ErrorAction SilentlyContinue
    }

    It 'throws for missing image path' {
        $missingPath = Join-Path $PSScriptRoot 'Input' 'Missing.png'
        $pdfPath = Join-Path $PSScriptRoot 'Output' 'ImageMissing.pdf'

        { New-PDF { New-PDFImage -ImagePath $missingPath } -FilePath $pdfPath } | Should -Throw -ErrorId 'ImageNotFound'
    }

    AfterAll {
        $folderPath = Join-Path $PSScriptRoot 'Output'
        Get-ChildItem -Path $folderPath -File | Remove-Item -ErrorAction SilentlyContinue
    }
}

