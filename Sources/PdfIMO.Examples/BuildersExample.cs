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
            14,
            TextAlignment.CENTER);
        document.Add(paragraph);
        document.Close();
    }
}
