namespace PSWritePDF;

/// <summary>Enumerates known PDF page size names.</summary>
public enum PdfPageSizeName
{
    A0,
    A1,
    A2,
    A3,
    A4,
    A5,
    A6,
    A7,
    A8,
    A9,
    A10,
    B0,
    B1,
    B2,
    B3,
    B4,
    B5,
    B6,
    B7,
    B8,
    B9,
    B10,
    Executive,
    LedgerOrTabloid,
    Legal,
    Letter,
    Unknown
}

/// <summary>Represents detailed information about a PDF page.</summary>
public class PdfPageDetails
{
    /// <summary>Height of the page in points.</summary>
    public int Height { get; set; }
    /// <summary>Width of the page in points.</summary>
    public int Width { get; set; }
    /// <summary>Rotation angle.</summary>
    public int Rotation { get; set; }
    /// <summary>Named page size.</summary>
    public PdfPageSizeName Size { get; set; } = PdfPageSizeName.Unknown;
    /// <summary>Indicates if the page is rotated.</summary>
    public bool? Rotated { get; set; }
}

/// <summary>Aggregated details for a PDF document.</summary>
public class PdfDocumentDetails
{
    /// <summary>Document author.</summary>
    public string? Author { get; set; }
    /// <summary>Document creator.</summary>
    public string? Creator { get; set; }
    /// <summary>Internal hash code.</summary>
    public int HashCode { get; set; }
    /// <summary>Document keywords.</summary>
    public string? Keywords { get; set; }
    /// <summary>Document producer.</summary>
    public string? Producer { get; set; }
    /// <summary>Document subject.</summary>
    public string? Subject { get; set; }
    /// <summary>Document title.</summary>
    public string? Title { get; set; }
    /// <summary>Trapping information.</summary>
    public string? Trapped { get; set; }
    /// <summary>PDF version used.</summary>
    public iText.Kernel.Pdf.PdfVersion Version { get; set; }
    /// <summary>Total number of pages.</summary>
    public int PagesNumber { get; set; }
    /// <summary>Left margin.</summary>
    public float MarginLeft { get; set; }
    /// <summary>Right margin.</summary>
    public float MarginRight { get; set; }
    /// <summary>Bottom margin.</summary>
    public float MarginBottom { get; set; }
    /// <summary>Top margin.</summary>
    public float MarginTop { get; set; }
    /// <summary>Information about individual pages.</summary>
    public System.Collections.Generic.Dictionary<int, PdfPageDetails> Pages { get; } = new();
}

internal static class PdfPageSizeLookup
{
    private static readonly System.Collections.Generic.Dictionary<(int Height, int Width), (PdfPageSizeName Size, bool Rotated)> Sizes = new()
    {
        {(3370,2384),(PdfPageSizeName.A0,false)},
        {(2384,3370),(PdfPageSizeName.A0,true)},
        {(2384,1684),(PdfPageSizeName.A1,false)},
        {(1684,2384),(PdfPageSizeName.A1,true)},
        {(105,74),(PdfPageSizeName.A10,false)},
        {(74,105),(PdfPageSizeName.A10,true)},
        {(1684,1190),(PdfPageSizeName.A2,false)},
        {(1190,1684),(PdfPageSizeName.A2,true)},
        {(1190,842),(PdfPageSizeName.A3,false)},
        {(842,1190),(PdfPageSizeName.A3,true)},
        {(842,595),(PdfPageSizeName.A4,false)},
        {(595,842),(PdfPageSizeName.A4,true)},
        {(595,420),(PdfPageSizeName.A5,false)},
        {(420,595),(PdfPageSizeName.A5,true)},
        {(420,298),(PdfPageSizeName.A6,false)},
        {(298,420),(PdfPageSizeName.A6,true)},
        {(298,210),(PdfPageSizeName.A7,false)},
        {(210,298),(PdfPageSizeName.A7,true)},
        {(210,148),(PdfPageSizeName.A8,false)},
        {(148,210),(PdfPageSizeName.A8,true)},
        {(547,105),(PdfPageSizeName.A9,false)},
        {(105,547),(PdfPageSizeName.A9,true)},
        {(4008,2834),(PdfPageSizeName.B0,false)},
        {(2834,4008),(PdfPageSizeName.B0,true)},
        {(2834,2004),(PdfPageSizeName.B1,false)},
        {(2004,2834),(PdfPageSizeName.B1,true)},
        {(124,88),(PdfPageSizeName.B10,false)},
        {(88,124),(PdfPageSizeName.B10,true)},
        {(2004,1417),(PdfPageSizeName.B2,false)},
        {(1417,2004),(PdfPageSizeName.B2,true)},
        {(1417,1000),(PdfPageSizeName.B3,false)},
        {(1000,1417),(PdfPageSizeName.B3,true)},
        {(1000,708),(PdfPageSizeName.B4,false)},
        {(708,1000),(PdfPageSizeName.B4,true)},
        {(708,498),(PdfPageSizeName.B5,false)},
        {(498,708),(PdfPageSizeName.B5,true)},
        {(498,354),(PdfPageSizeName.B6,false)},
        {(354,498),(PdfPageSizeName.B6,true)},
        {(354,249),(PdfPageSizeName.B7,false)},
        {(249,354),(PdfPageSizeName.B7,true)},
        {(249,175),(PdfPageSizeName.B8,false)},
        {(175,249),(PdfPageSizeName.B8,true)},
        {(175,124),(PdfPageSizeName.B9,false)},
        {(124,175),(PdfPageSizeName.B9,true)},
        {(756,522),(PdfPageSizeName.Executive,false)},
        {(522,756),(PdfPageSizeName.Executive,true)},
        {(792,1224),(PdfPageSizeName.LedgerOrTabloid,false)},
        {(1224,792),(PdfPageSizeName.LedgerOrTabloid,true)},
        {(1008,612),(PdfPageSizeName.Legal,false)},
        {(612,1008),(PdfPageSizeName.Legal,true)},
        {(792,612),(PdfPageSizeName.Letter,false)},
        {(612,792),(PdfPageSizeName.Letter,true)},
    };

    public static (PdfPageSizeName Size, bool? Rotated) Get(int height, int width)
    {
        return Sizes.TryGetValue((height, width), out var value) ? (value.Size, value.Rotated) : (PdfPageSizeName.Unknown, null);
    }
}
