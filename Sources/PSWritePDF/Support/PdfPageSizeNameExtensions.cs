namespace PSWritePDF;

internal static class PdfPageSizeNameExtensions
{
    public static iText.Kernel.Geom.PageSize ToPageSize(this PdfPageSizeName size)
        => size switch
        {
            PdfPageSizeName.A0 => iText.Kernel.Geom.PageSize.A0,
            PdfPageSizeName.A1 => iText.Kernel.Geom.PageSize.A1,
            PdfPageSizeName.A2 => iText.Kernel.Geom.PageSize.A2,
            PdfPageSizeName.A3 => iText.Kernel.Geom.PageSize.A3,
            PdfPageSizeName.A4 => iText.Kernel.Geom.PageSize.A4,
            PdfPageSizeName.A5 => iText.Kernel.Geom.PageSize.A5,
            PdfPageSizeName.A6 => iText.Kernel.Geom.PageSize.A6,
            PdfPageSizeName.A7 => iText.Kernel.Geom.PageSize.A7,
            PdfPageSizeName.A8 => iText.Kernel.Geom.PageSize.A8,
            PdfPageSizeName.A9 => iText.Kernel.Geom.PageSize.A9,
            PdfPageSizeName.A10 => iText.Kernel.Geom.PageSize.A10,
            PdfPageSizeName.B0 => iText.Kernel.Geom.PageSize.B0,
            PdfPageSizeName.B1 => iText.Kernel.Geom.PageSize.B1,
            PdfPageSizeName.B2 => iText.Kernel.Geom.PageSize.B2,
            PdfPageSizeName.B3 => iText.Kernel.Geom.PageSize.B3,
            PdfPageSizeName.B4 => iText.Kernel.Geom.PageSize.B4,
            PdfPageSizeName.B5 => iText.Kernel.Geom.PageSize.B5,
            PdfPageSizeName.B6 => iText.Kernel.Geom.PageSize.B6,
            PdfPageSizeName.B7 => iText.Kernel.Geom.PageSize.B7,
            PdfPageSizeName.B8 => iText.Kernel.Geom.PageSize.B8,
            PdfPageSizeName.B9 => iText.Kernel.Geom.PageSize.B9,
            PdfPageSizeName.B10 => iText.Kernel.Geom.PageSize.B10,
            PdfPageSizeName.Executive => iText.Kernel.Geom.PageSize.EXECUTIVE,
            PdfPageSizeName.LedgerOrTabloid => iText.Kernel.Geom.PageSize.LEDGER,
            PdfPageSizeName.Legal => iText.Kernel.Geom.PageSize.LEGAL,
            PdfPageSizeName.Letter => iText.Kernel.Geom.PageSize.LETTER,
            _ => iText.Kernel.Geom.PageSize.A4,
        };
}
