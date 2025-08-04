using iText.Kernel.Colors;
using iText.Kernel.Font;
using iText.Kernel.Geom;

namespace PdfIMO
{
    internal static class PdfHelpers
    {
        public static PdfFont CreateFont(PdfFontName font) =>
            PdfFontFactory.CreateFont(PdfFontLookup.GetFont(font));

        public static Color GetColor(PdfColor color) =>
            PdfColorLookup.GetColor(color);

        public static PageSize GetPageSize(PdfPageSize size) => size switch
            {
                PdfPageSize.A4 => PageSize.A4,
                PdfPageSize.A5 => PageSize.A5,
                PdfPageSize.Letter => PageSize.LETTER,
                PdfPageSize.Legal => PageSize.LEGAL,
                _ => PageSize.A4
            };
    }
}
