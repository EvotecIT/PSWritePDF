using System.Management.Automation;
using iText.Layout;
using PdfIMO;
using iTextPdf = iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFPage")]
public class CmdletNewPDFPage : PSCmdlet {
    [Parameter(Position = 0)]
    public ScriptBlock? PageContent { get; set; }

    [Parameter] public double? MarginLeft { get; set; }
    [Parameter] public double? MarginRight { get; set; }
    [Parameter] public double? MarginTop { get; set; }
    [Parameter] public double? MarginBottom { get; set; }
    [Parameter] public PdfPageSize? PageSize { get; set; }
    [Parameter] public SwitchParameter Rotate { get; set; }

    protected override void ProcessRecord() {
        var pdfDocument = SessionState.PSVariable.GetValue("PdfDocument") as iTextPdf.PdfDocument;
        if (pdfDocument == null) {
            throw new PSInvalidOperationException("PdfDocument variable not found. Call New-PDF first.");
        }
        var size = PageSize ?? PdfPageSize.Default;
        var document = PdfPage.AddPage(pdfDocument, size, Rotate.IsPresent, (float?)MarginLeft, (float?)MarginRight, (float?)MarginTop, (float?)MarginBottom);
        SessionState.PSVariable.Set("Document", document);
        PageContent?.Invoke();
    }
}
