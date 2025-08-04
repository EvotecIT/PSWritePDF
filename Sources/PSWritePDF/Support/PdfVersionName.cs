namespace PSWritePDF;

public enum PdfVersionName
{
    PDF_1_0,
    PDF_1_1,
    PDF_1_2,
    PDF_1_3,
    PDF_1_4,
    PDF_1_5,
    PDF_1_6,
    PDF_1_7,
    PDF_2_0
}

internal static class PdfVersionNameExtensions
{
    public static iText.Kernel.Pdf.PdfVersion ToPdfVersion(this PdfVersionName version)
        => version switch
        {
            PdfVersionName.PDF_1_0 => iText.Kernel.Pdf.PdfVersion.PDF_1_0,
            PdfVersionName.PDF_1_1 => iText.Kernel.Pdf.PdfVersion.PDF_1_1,
            PdfVersionName.PDF_1_2 => iText.Kernel.Pdf.PdfVersion.PDF_1_2,
            PdfVersionName.PDF_1_3 => iText.Kernel.Pdf.PdfVersion.PDF_1_3,
            PdfVersionName.PDF_1_4 => iText.Kernel.Pdf.PdfVersion.PDF_1_4,
            PdfVersionName.PDF_1_5 => iText.Kernel.Pdf.PdfVersion.PDF_1_5,
            PdfVersionName.PDF_1_6 => iText.Kernel.Pdf.PdfVersion.PDF_1_6,
            PdfVersionName.PDF_1_7 => iText.Kernel.Pdf.PdfVersion.PDF_1_7,
            PdfVersionName.PDF_2_0 => iText.Kernel.Pdf.PdfVersion.PDF_2_0,
            _ => iText.Kernel.Pdf.PdfVersion.PDF_1_7,
        };
}
