using System;
using iText.IO.Font.Constants;
using iText.Kernel.Colors;
using iText.Kernel.Font;
using iText.Kernel.Geom;

namespace PdfIMO
{
    internal static class PdfHelpers
    {
        public static PdfFont CreateFont(PdfFontName font) => PdfFontFactory.CreateFont(font switch
        {
            PdfFontName.COURIER => StandardFonts.COURIER,
            PdfFontName.COURIER_BOLD => StandardFonts.COURIER_BOLD,
            PdfFontName.COURIER_OBLIQUE => StandardFonts.COURIER_OBLIQUE,
            PdfFontName.COURIER_BOLDOBLIQUE => StandardFonts.COURIER_BOLDOBLIQUE,
            PdfFontName.HELVETICA => StandardFonts.HELVETICA,
            PdfFontName.HELVETICA_BOLD => StandardFonts.HELVETICA_BOLD,
            PdfFontName.HELVETICA_OBLIQUE => StandardFonts.HELVETICA_OBLIQUE,
            PdfFontName.HELVETICA_BOLDOBLIQUE => StandardFonts.HELVETICA_BOLDOBLIQUE,
            PdfFontName.SYMBOL => StandardFonts.SYMBOL,
            PdfFontName.TIMES_ROMAN => StandardFonts.TIMES_ROMAN,
            PdfFontName.TIMES_BOLD => StandardFonts.TIMES_BOLD,
            PdfFontName.TIMES_ITALIC => StandardFonts.TIMES_ITALIC,
            PdfFontName.TIMES_BOLDITALIC => StandardFonts.TIMES_BOLDITALIC,
            PdfFontName.ZAPFDINGBATS => StandardFonts.ZAPFDINGBATS,
            _ => throw new ArgumentOutOfRangeException(nameof(font), font, null)
        });

        public static Color GetColor(PdfColor color) => color switch
        {
            PdfColor.Black => ColorConstants.BLACK,
            PdfColor.Blue => ColorConstants.BLUE,
            PdfColor.Red => ColorConstants.RED,
            PdfColor.Green => ColorConstants.GREEN,
            PdfColor.Gray => ColorConstants.GRAY,
            _ => ColorConstants.BLACK
        };

        public static PageSize GetPageSize(PdfPageSize size) => size switch
        {
            PdfPageSize.A4 => PageSize.A4,
            PdfPageSize.Letter => PageSize.LETTER,
            PdfPageSize.Legal => PageSize.LEGAL,
            _ => PageSize.A4
        };
    }
}
