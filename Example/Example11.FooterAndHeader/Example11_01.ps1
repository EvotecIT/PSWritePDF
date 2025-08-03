# https://stackoverflow.com/questions/59654948/how-to-add-header-and-footer-to-a-pdf-with-itext-7
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
PdfDocument pdfDoc = new PdfDocument(new PdfReader(SRC), new PdfWriter(dest));
Document doc = new Document(pdfDoc);
Paragraph header = new Paragraph("Copy")
        .setFont(PdfFontFactory.createFont(StandardFonts.HELVETICA)).setFontSize(6);

for (int i = 1; i <= pdfDoc.getNumberOfPages(); i++) {
    PdfPage pdfPage = pdfDoc.getPage(i);

    // When "true": in case the page has a rotation, then new content will be automatically rotated in the
    // opposite direction. On the rotated page this would look as if new content ignores page rotation.
    pdfPage.setIgnorePageRotationForContent(true);

    Rectangle pageSize = pdfPage.getPageSize();
    float x, y;
    if (pdfPage.getRotation() % 180 == 0) {
        x = pageSize.getWidth() / 2;
        y = pageSize.getTop() - 20;
    } else {
        x = pageSize.getHeight() / 2;
        y = pageSize.getRight() - 20;
    }

    doc.showTextAligned(header, x, y, i, TextAlignment.CENTER, VerticalAlignment.BOTTOM, 0);
}

doc.close();

#>