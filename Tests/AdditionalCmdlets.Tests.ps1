Describe 'Additional cmdlets' {
    BeforeAll {
        New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output' | Out-Null
    }

    It 'New-PDFArea returns rotated size' {
        $area = New-PDFArea -PageSize A4 -Rotate
        $size = $area.GetPageSize()
        [int]$size.GetHeight() | Should -Be 595
        [int]$size.GetWidth() | Should -Be 842
    }

    It 'New-PDFDocument creates document object' {
        $file = Join-Path $PSScriptRoot 'Output' 'doc.pdf'
        New-PDF -FilePath $file | Out-Null
        $pdf = Get-PDF -FilePath $file
        $doc = New-PDFDocument -PDF $pdf
        $doc | Should -BeOfType 'iText.Layout.Document'
        Close-PDF -Document $pdf
    }

    It 'New-PDFInfo sets metadata' {
        $file = Join-Path $PSScriptRoot 'Output' 'info.pdf'
        New-PDF -FilePath $file | Out-Null
        $pdf = Get-PDF -FilePath $file
        New-PDFInfo -PDF $pdf -Title 'TestTitle' -Author 'TestAuthor' -AddCreationDate | Out-Null
        $info = $pdf.GetDocumentInfo()
        $info.GetTitle() | Should -Be 'TestTitle'
        $info.GetAuthor() | Should -Be 'TestAuthor'
        $info.GetMoreInfo('CreationDate') | Should -Not -BeNullOrEmpty
        Close-PDF -Document $pdf
    }

    It 'Register-PDFFont registers font' {
        $fontPath = '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf'
        $font = Register-PDFFont -FontName 'DejaVuSans' -FontPath $fontPath -Encoding IdentityH -Cached -Default
        $font | Should -BeOfType 'iText.Kernel.Font.PdfFont'
        $default = Get-Variable -Name DefaultFont -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Value
        $default | Should -Not -BeNullOrEmpty
    }

    It 'New-PDFPage -PassThru returns document' {
        $file = Join-Path $PSScriptRoot 'Output' 'page.pdf'
        New-PDF -FilePath $file {
            $doc = New-PDFPage -PassThru {
                New-PDFText -Text 'Hi'
            }
            $doc | Should -BeOfType 'iText.Layout.Document'
        }
    }

    It 'New-PDFOptions -PassThru returns document when available' {
        $file = Join-Path $PSScriptRoot 'Output' 'optionsdoc.pdf'
        New-PDF -FilePath $file {
            $doc = New-PDFOptions -MarginLeft 15 -PassThru
            $doc | Should -BeOfType 'iText.Layout.Document'
        }
    }

    It 'New-PDFOptions -PassThru returns options object when document missing' {
        $options = New-PDFOptions -MarginLeft 10 -PassThru
        $options | Should -BeOfType 'PSWritePDF.PdfDocumentOptions'
        $options.MarginLeft | Should -Be 10
    }
}
