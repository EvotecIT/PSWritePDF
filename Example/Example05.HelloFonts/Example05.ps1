Import-Module .\PSWritePDF.psd1 -Force


$DataTable1 = @(
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
)

$DataTable2 = @(
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
)

$OutputFile = "$PSScriptRoot\Test.pdf"
[iText.Kernel.Pdf.PdfWriter] $Writer = [iText.Kernel.Pdf.PdfWriter]::new($OutputFile)
[iText.Kernel.Pdf.PdfDocument] $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Writer);
[iText.Layout.Document] $Document = [iText.Layout.Document]::new($PDF)

#$PDF.GetCatalog().

#[iText.Kernel.Pdf.WriterProperties]::new()

$Table = New-PDFTable -DataTable $DataTable
$null = $Document.Add($Table)

<#

#[iText.layout.element.Table] $Table = [iText.layout.element.Table]::new([iText.Layout.Properties.UnitValue]::CreatePercentArray(8)).useAllAvailableWidth()
[iText.layout.element.Table] $Table = [iText.layout.element.Table]::new(10).UseAllAvailableWidth()

for ($i = 0; $i -lt 16; $i++) {
    $Paragraph = New-PDFText -Text 'Hello in Cell' -FontColor BLUE

    [iText.Layout.Element.Cell] $Cell = [iText.Layout.Element.Cell]::new().Add($Paragraph)
    $null = $table.AddCell($Cell)
}

$null = $Document.Add($Table)
#>

$Document.Close()
$PDF.Close()
$Writer.Close()