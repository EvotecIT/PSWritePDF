using iText.Kernel.Pdf;
using iText.Layout.Properties;
using PdfIMO;

namespace PdfIMO.Examples;

public static class BuildersExample
{
    public static void Run()
    {
        var path = "Example13_PdfIMOBuilders.pdf";
        using var writer = new PdfWriter(path);
        using var pdf = new PdfDocument(writer);
        using var document = PdfPage.AddPage(pdf, PdfPageSize.A4, marginLeft: 20, marginRight: 20);

        var paragraph = PdfText.CreateParagraph(
            new[] { "Hello PdfIMO Builders" },
            new[] { PdfFontName.HELVETICA },
            new[] { PdfColor.Red },
            null,
            14,
            TextAlignment.CENTER);
        document.Add(paragraph);

        var items = new[] { "First", "Second", "Third" };
        PdfList.AddList(document, items, indent: 10, symbol: ListSymbol.Bullet);

        var tableData = new[]
        {
            new { Name = "Alice", Value = 1 },
            new { Name = "Bob", Value = 2 }
        };
        var table = PdfTable.BuildTable(tableData);
        document.Add(table);

        document.Close();
    }
}
