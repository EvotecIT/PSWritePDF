namespace PSWritePDF;

public enum PdfActionName
{
    RESET_EXCLUDE,
    SUBMIT_CANONICAL_FORMAT,
    SUBMIT_COORDINATES,
    SUBMIT_EMBED_FORM,
    SUBMIT_EXCLUDE,
    SUBMIT_EXCL_F_KEY,
    SUBMIT_EXCL_NON_USER_ANNOTS,
    SUBMIT_HTML_FORMAT,
    SUBMIT_HTML_GET,
    SUBMIT_INCLUDE_ANNOTATIONS,
    SUBMIT_INCLUDE_APPEND_SAVES,
    SUBMIT_INCLUDE_NO_VALUE_FIELDS,
    SUBMIT_PDF,
    SUBMIT_XFDF
}

internal static class PdfActionNameExtensions
{
    public static int ToInt(this PdfActionName action)
        => action switch
        {
            PdfActionName.RESET_EXCLUDE => iText.Kernel.Pdf.Action.PdfAction.RESET_EXCLUDE,
            PdfActionName.SUBMIT_CANONICAL_FORMAT => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_CANONICAL_FORMAT,
            PdfActionName.SUBMIT_COORDINATES => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_COORDINATES,
            PdfActionName.SUBMIT_EMBED_FORM => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_EMBED_FORM,
            PdfActionName.SUBMIT_EXCLUDE => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_EXCLUDE,
            PdfActionName.SUBMIT_EXCL_F_KEY => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_EXCL_F_KEY,
            PdfActionName.SUBMIT_EXCL_NON_USER_ANNOTS => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_EXCL_NON_USER_ANNOTS,
            PdfActionName.SUBMIT_HTML_FORMAT => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_HTML_FORMAT,
            PdfActionName.SUBMIT_HTML_GET => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_HTML_GET,
            PdfActionName.SUBMIT_INCLUDE_ANNOTATIONS => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_INCLUDE_ANNOTATIONS,
            PdfActionName.SUBMIT_INCLUDE_APPEND_SAVES => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_INCLUDE_APPEND_SAVES,
            PdfActionName.SUBMIT_INCLUDE_NO_VALUE_FIELDS => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_INCLUDE_NO_VALUE_FIELDS,
            PdfActionName.SUBMIT_PDF => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_PDF,
            PdfActionName.SUBMIT_XFDF => iText.Kernel.Pdf.Action.PdfAction.SUBMIT_XFDF,
            _ => 0,
        };
}
