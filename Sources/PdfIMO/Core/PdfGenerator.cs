using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;

namespace PdfIMO
{
    public static class PdfGenerator
    {
        public static void CreateSimplePdf(string path)
        {
            using var writer = new PdfWriter(path);
            using var pdf = new PdfDocument(writer);
            using var document = new Document(pdf);
            document.Add(new Paragraph("Hello from PdfIMO"));
        }
    }
}
