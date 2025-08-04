namespace PSWritePDF;

public enum PdfFontEncoding
{
    None,
    IdentityH,
    IdentityV,
    PdfDocEncoding,
    WinAnsi,
    Utf8
}

internal static class PdfFontEncodingExtensions
{
    private static readonly System.Collections.Generic.Dictionary<PdfFontEncoding, string> Map = new()
    {
        { PdfFontEncoding.None, string.Empty },
        { PdfFontEncoding.IdentityH, iText.IO.Font.PdfEncodings.IDENTITY_H },
        { PdfFontEncoding.IdentityV, iText.IO.Font.PdfEncodings.IDENTITY_V },
        { PdfFontEncoding.PdfDocEncoding, iText.IO.Font.PdfEncodings.PDF_DOC_ENCODING },
        { PdfFontEncoding.WinAnsi, iText.IO.Font.PdfEncodings.WINANSI },
        { PdfFontEncoding.Utf8, iText.IO.Font.PdfEncodings.UTF8 }
    };

    public static string? ToEncodingString(this PdfFontEncoding encoding)
        => Map.TryGetValue(encoding, out var value) ? value : null;
}
