using System;

namespace PSWritePDF;

/// <summary>Defines margin settings for a PDF document.</summary>
public class PdfDocumentOptions
{
    /// <summary>Left margin in points.</summary>
    public float? MarginLeft { get; set; }
    /// <summary>Right margin in points.</summary>
    public float? MarginRight { get; set; }
    /// <summary>Top margin in points.</summary>
    public float? MarginTop { get; set; }
    /// <summary>Bottom margin in points.</summary>
    public float? MarginBottom { get; set; }
}
