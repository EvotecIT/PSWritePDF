using System.IO;
using System.Text;
using iText.Kernel.Pdf;
using PdfIMO;
using iText.Layout.Properties;
using Xunit;

namespace PdfIMO.Tests
{
    public class PdfBuildersTests
    {
        [Fact]
        public void TextAndPageBuilders_CreatePdfWithParagraph()
        {
            var tempFile = Path.GetTempFileName();
            try
            {
                using var writer = new PdfWriter(tempFile);
                using var pdf = new PdfDocument(writer);
                using var document = PdfPage.AddPage(pdf, PdfPageSize.A4, marginLeft: 10, marginRight: 10);

                var paragraph = PdfText.CreateParagraph(
                    new[] { "Hello from builders" },
                    new[] { PdfHelpers.CreateFont(PdfFontName.HELVETICA) },
                    new[] { PdfColor.Blue },
                    null,
                    12,
                    TextAlignment.CENTER);

                document.Add(paragraph);
                document.Close();

                Assert.True(File.Exists(tempFile));
                using var stream = File.OpenRead(tempFile);
                var buffer = new byte[4];
                _ = stream.Read(buffer, 0, buffer.Length);
                Assert.Equal("%PDF", Encoding.ASCII.GetString(buffer));
            }
            finally
            {
                if (File.Exists(tempFile))
                {
                    File.Delete(tempFile);
                }
            }
        }

        [Fact]
        public void ListBuilder_AddsListToDocument()
        {
            var tempFile = Path.GetTempFileName();
            try
            {
                using var writer = new PdfWriter(tempFile);
                using var pdf = new PdfDocument(writer);
                using var document = PdfPage.AddPage(pdf, PdfPageSize.A4);

                PdfList.AddList(document, new[] { "One", "Two" });
                document.Close();

                Assert.True(File.Exists(tempFile));
                using var stream = File.OpenRead(tempFile);
                var buffer = new byte[4];
                _ = stream.Read(buffer, 0, buffer.Length);
                Assert.Equal("%PDF", Encoding.ASCII.GetString(buffer));
            }
            finally
            {
                if (File.Exists(tempFile))
                {
                    File.Delete(tempFile);
                }
            }
        }

        [Fact]
        public void TableBuilder_BuildsTable()
        {
            var tempFile = Path.GetTempFileName();
            try
            {
                using var writer = new PdfWriter(tempFile);
                using var pdf = new PdfDocument(writer);
                using var document = PdfPage.AddPage(pdf, PdfPageSize.A4);

                var table = PdfTable.BuildTable(new[]
                {
                    new { Name = "A", Value = 1 },
                    new { Name = "B", Value = 2 }
                });
                document.Add(table);
                document.Close();

                Assert.True(File.Exists(tempFile));
                using var stream = File.OpenRead(tempFile);
                var buffer = new byte[4];
                _ = stream.Read(buffer, 0, buffer.Length);
                Assert.Equal("%PDF", Encoding.ASCII.GetString(buffer));
            }
            finally
            {
                if (File.Exists(tempFile))
                {
                    File.Delete(tempFile);
                }
            }
        }
    }
}
