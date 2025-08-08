using iText.Kernel.Pdf.Canvas.Parser.Listener;

namespace PSWritePDF;

/// <summary>Defines text extraction strategies for PDFs.</summary>
public enum PdfExtractionStrategyName
{
    Simple,
    Location
}

internal static class PdfExtractionStrategyNameExtensions
{
    public static ITextExtractionStrategy ToStrategy(this PdfExtractionStrategyName name)
    {
        return name switch
        {
            PdfExtractionStrategyName.Location => new LocationTextExtractionStrategy(),
            _ => new SimpleTextExtractionStrategy(),
        };
    }
}

