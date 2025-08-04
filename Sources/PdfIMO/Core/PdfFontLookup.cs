using System;
using System.Collections.Generic;
using iText.IO.Font.Constants;

namespace PdfIMO;

public static class PdfFontLookup
{
    private static readonly Dictionary<PdfFontName, string> Fonts = new()
    {
        { PdfFontName.COURIER, StandardFonts.COURIER },
        { PdfFontName.COURIER_BOLD, StandardFonts.COURIER_BOLD },
        { PdfFontName.COURIER_OBLIQUE, StandardFonts.COURIER_OBLIQUE },
        { PdfFontName.COURIER_BOLDOBLIQUE, StandardFonts.COURIER_BOLDOBLIQUE },
        { PdfFontName.HELVETICA, StandardFonts.HELVETICA },
        { PdfFontName.HELVETICA_BOLD, StandardFonts.HELVETICA_BOLD },
        { PdfFontName.HELVETICA_OBLIQUE, StandardFonts.HELVETICA_OBLIQUE },
        { PdfFontName.HELVETICA_BOLDOBLIQUE, StandardFonts.HELVETICA_BOLDOBLIQUE },
        { PdfFontName.SYMBOL, StandardFonts.SYMBOL },
        { PdfFontName.TIMES_ROMAN, StandardFonts.TIMES_ROMAN },
        { PdfFontName.TIMES_BOLD, StandardFonts.TIMES_BOLD },
        { PdfFontName.TIMES_ITALIC, StandardFonts.TIMES_ITALIC },
        { PdfFontName.TIMES_BOLDITALIC, StandardFonts.TIMES_BOLDITALIC },
        { PdfFontName.ZAPFDINGBATS, StandardFonts.ZAPFDINGBATS }
    };

    private static readonly string[] FontNames = Enum.GetNames(typeof(PdfFontName));

    public static string GetFont(PdfFontName font) => Fonts[font];

    public static string GetFont(string name)
    {
        if (!Enum.TryParse(name, true, out PdfFontName fontEnum))
            throw new ArgumentException($"Font '{name}' was not found in StandardFonts.", nameof(name));
        return GetFont(fontEnum);
    }

    public static IReadOnlyCollection<string> Names => FontNames;
}

