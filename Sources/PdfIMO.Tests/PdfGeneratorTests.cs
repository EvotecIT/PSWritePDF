using System.IO;
using System.Text;
using PdfIMO;
using Xunit;

namespace PdfIMO.Tests
{
    public class PdfGeneratorTests
    {
        [Fact]
        public void CreateSimplePdf_CreatesFileWithPdfHeader()
        {
            var tempFile = Path.GetTempFileName();
            try
            {
                PdfGenerator.CreateSimplePdf(tempFile);
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
