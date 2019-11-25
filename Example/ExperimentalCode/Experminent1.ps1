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

$OutputFile = "$PSScriptRoot\Experiment1.pdf"

$PDF = New-PDF -PageSize A4 -Rotate -FilePath $OutputFile

New-PDFInfo -PDF $PDF -Title 'PSWritePDF Example' -Creator 'Przemyslaw Klys' -AddModificationDate -AddCreationDate

$Document = New-PDFDocument -PDF $PDF

$Text = New-PDFText -Text "Be prepared to read a story about a London lawyer named Gabriel John Utterson who investigates strange occurrences between his old friend, Dr. Henry Jekyll, and the evil Edward Hyde."
$null = $Document.Add($Text)

$AreaBreak1 = New-PDFArea -Rotate -PageSize B3

$null = $Document.Add($AreaBreak1)

$Table1 = New-PDFTable -DataTable $DataTable2
$null = $Document.Add($Table1)


$AreaBreak2 = New-PDFArea -PageSize A4 #-Rotate
$null = $Document.Add($AreaBreak2)

$Text = New-PDFText -Text "Be prepared to read a story about a London lawyer named Gabriel John Utterson who investigates strange occurrences between his old friend, Dr. Henry Jekyll, and the evil Edward Hyde."
$null = $Document.Add($Text)


$AreaBreak1 = New-PDFArea -PageSize A4
$null = $Document.Add($AreaBreak1)

$Text = New-PDFText -Text "Be prepared to read a story about a London lawyer named Gabriel John Utterson who investigates strange occurrences between his old friend, Dr. Henry Jekyll, and the evil Edward Hyde."
$Null = $Document.Add($Text)
#>
$Document.Close()
if (Test-Path -LiteralPath $OutputFile) {
    Invoke-Item -LiteralPath $OutputFile
}


<#
iText.Layout.Renderer.DocumentRenderer new(iText.Layout.Document document)
iText.Layout.Renderer.DocumentRenderer new(iText.Layout.Document document, bool immediateFlush)
#>
#$DocumentRenderer = [iText.Layout.Renderer.DocumentRenderer]::new

<#
iText.Layout.ColumnDocumentRenderer new(iText.Layout.Document document, iText.Kernel.Geom.Rectangle[] columns)
iText.Layout.ColumnDocumentRenderer new(iText.Layout.Document document, bool immediateFlush, iText.Kernel.Geom.Rectangle[] columns)
#>
#$ColumnRenderer = [iText.Layout.ColumnDocumentRenderer]::new($Document)

#$Document.SetRenderer




#$PDFPage = $PDF.AddNewPage([iText.Kernel.Geom.PageSize]::A4)

#$PageSize = [iText.Kernel.Geom.PageSize]::A4
#$PageSize = $Pagesize.Rotate()



#$Text1 = New-PDFText -Text 'test2'

#$AreaBreak1 = [iText.Layout.Element.AreaBreak]::new($PageSize)
#$AreaBreak.
#$Document.add($AreaBreak1)

<#
iText.Layout.Element.AreaBreak new()
iText.Layout.Element.AreaBreak new(System.Nullable[iText.Layout.Properties.AreaBreakType] areaBreakType)
iText.Layout.Element.AreaBreak new(iText.Kernel.Geom.PageSize pageSize)

#>

#$Rectangle = [iText.Kernel.Geom.Rectangle]::new(36, 650, 100, 100)
#$Canvas = [iText.Layout.Canvas]::new($PDFPage, $Rectangle)

#$Can = [iText.Kernel.Pdf.Canvas.PdfCanvas]::new($PDFPage)
#$Can.Add('t')

#[iText.Layout.RootElement] $T = [iText.Layout.RootElement]

<#
iText.Layout.Canvas new(iText.Kernel.Pdf.PdfPage page, iText.Kernel.Geom.Rectangle rootArea)
iText.Layout.Canvas new(iText.Kernel.Pdf.Canvas.PdfCanvas pdfCanvas, iText.Kernel.Pdf.PdfDocument pdfDocument, iText.Kernel.Geom.Rectangle rootArea)
iText.Layout.Canvas new(iText.Kernel.Pdf.Canvas.PdfCanvas pdfCanvas, iText.Kernel.Pdf.PdfDocument pdfDocument, iText.Kernel.Geom.Rectangle rootArea, bool immediateFlush)
iText.Layout.Canvas new(iText.Kernel.Pdf.Xobject.PdfFormXObject formXObject, iText.Kernel.Pdf.PdfDocument pdfDocument)

#>

#$PDFPage = $PDF.AddNewPage($PageSize)



#$Canvas = [iText.Kernel.Pdf.Canvas.PdfCanvas]::new($PDFPage)
#$Canvas.AddXObject
<#
iText.Kernel.Pdf.Canvas.PdfCanvas new(iText.Kernel.Pdf.PdfStream contentStream, iText.Kernel.Pdf.PdfResources resources, iText.Kernel.Pdf.PdfDocument document)
iText.Kernel.Pdf.Canvas.PdfCanvas new(iText.Kernel.Pdf.PdfPage page)
iText.Kernel.Pdf.Canvas.PdfCanvas new(iText.Kernel.Pdf.PdfPage page, bool wrapOldContent)
iText.Kernel.Pdf.Canvas.PdfCanvas new(iText.Kernel.Pdf.Xobject.PdfFormXObject xObj, iText.Kernel.Pdf.PdfDocument document)
iText.Kernel.Pdf.Canvas.PdfCanvas new(iText.Kernel.Pdf.PdfDocument doc, int pageNum)
#>

#$Rectangle = [iText.Kernel.Geom.Rectangle]::new(36, 650, 100, 100)


#[iText.Layout.Document] $Document = [iText.Layout.Document]::new($PDF)


#[int] $n = $pdf.getNumberOfPages();

#for ($page = 1; $page -le $n; $page++) {
#   [iText.Layout.Element.Paragraph] $footer = [iText.Layout.Element.Paragraph]::new("Page nr $Page of $n")
# $Document.ShowTextAligned($footer, 297.5, 20, $page, [iText.Layout.Properties.TextAlignment]::CENTER, [iText.Layout.Properties.VerticalAlignment]::MIDDLE, 0)

<#
    iText.Layout.Document ShowTextAligned(string text, float x, float y, System.Nullable[iText.Layout.Properties.TextAlignment] textAlign)
    iText.Layout.Document ShowTextAligned(string text, float x, float y, System.Nullable[iText.Layout.Properties.TextAlignment] textAlign, float angle)
    iText.Layout.Document ShowTextAligned(string text, float x, float y, System.Nullable[iText.Layout.Properties.TextAlignment] textAlign, System.Nullable[iText.Layout.Properties.VerticalAlignment] vertAlign, float angle)
    iText.Layout.Document ShowTextAligned(iText.Layout.Element.Paragraph p, float x, float y, System.Nullable[iText.Layout.Properties.TextAlignment] textAlign)
    iText.Layout.Document ShowTextAligned(iText.Layout.Element.Paragraph p, float x, float y, System.Nullable[iText.Layout.Properties.TextAlignment] textAlign, System.Nullable[iText.Layout.Properties.VerticalAlignment] vertAlign)
    iText.Layout.Document ShowTextAligned(iText.Layout.Element.Paragraph p, float x, float y, int pageNumber, System.Nullable[iText.Layout.Properties.TextAlignment] textAlign, System.Nullable[iText.Layout.Properties.VerticalAlignment] vertAlign, float radAngle)
    #>
#}
#document.close();


#$PDF.GetCatalog().

<#

$Table = New-PDFTable -DataTable $DataTable1
$null = $Document.Add($Table)
#>


# Add image
<#
$FoxPNG = "$PSScriptRoot\CodeADSI.png"
$Fox = [iText.IO.Image.ImageDataFactory]::Create($FoxPNG)
[iText.Layout.Element.Image] $foxImage = [iText.Layout.Element.Image]::new($Fox)
$Document.Add($foxImage)
#>



<#
# Another table
$Table1 = New-PDFTable -DataTable $DataTable2
$null = $Document.Add($Table1)

#>
#[iText.Kernel.Pdf.PdfName] $Name = [iText.Kernel.Pdf.PdfName].
#$info.SetMoreInfo('something','something else')

<#
$PageSize = [iText.Kernel.Geom.PageSize]::A4
$PDFPage = $PDF.AddNewPage($PageSize)

$PageSize = [iText.Kernel.Geom.PageSize]::A10
$PDFPage = $PDF.AddNewPage($PageSize)

[iText.Layout.Document] $Document1 = [iText.Layout.Document]::new($PDFPage)

$Table = New-PDFTable -DataTable $DataTable2
$null = $Document1.Add($Table)

$PDFPage.GetRotation()
#$PDFPage.
#>
#$pdf.SetDefaultPageSize([iText.Kernel.Geom.PageSize]::A4.Rotate())


#[iText.Kernel.Pdf.PdfDocument] $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Writer);
#[iText.Layout.Document] $Document = [iText.Layout.Document]::new($PDF)

#$Table = New-PDFTable -DataTable $DataTable2
#$null = $Document.Add($Table)

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