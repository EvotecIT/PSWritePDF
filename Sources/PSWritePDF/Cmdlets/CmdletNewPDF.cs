using System;
using System.IO;
using System.Management.Automation;
using iText.Layout;
using iText.Layout.Properties;
using PdfIMO;
using iTextPdf = iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDF")]
public class CmdletNewPDF : PSCmdlet {
    [Parameter(Position = 0)]
    public ScriptBlock? PDFContent { get; set; }

    [Parameter(Mandatory = true)]
    public string FilePath { get; set; } = string.Empty;

    [Parameter]
    public string? Version { get; set; }

    [Parameter] public double? MarginLeft { get; set; }
    [Parameter] public double? MarginRight { get; set; }
    [Parameter] public double? MarginTop { get; set; }
    [Parameter] public double? MarginBottom { get; set; }
    [Parameter] public PdfPageSize? PageSize { get; set; }
    [Parameter] public SwitchParameter Rotate { get; set; }
    [Parameter, Alias("Open")] public SwitchParameter Show { get; set; }

    protected override void ProcessRecord() {
        iTextPdf.PdfWriter writer;
        if (!string.IsNullOrEmpty(Version)) {
            var enumName = "PDF_" + Version.Replace('.', '_');
            var pdfVersion = (iTextPdf.PdfVersion)Enum.Parse(typeof(iTextPdf.PdfVersion), enumName, true);
            var props = new iTextPdf.WriterProperties().SetPdfVersion(pdfVersion);
            writer = new iTextPdf.PdfWriter(FilePath, props);
        } else {
            writer = new iTextPdf.PdfWriter(FilePath);
        }

        var pdfDocument = new iTextPdf.PdfDocument(writer);
        var size = PageSize ?? PdfPageSize.Default;
        var document = PdfPage.AddPage(pdfDocument, size, Rotate.IsPresent, (float?)MarginLeft, (float?)MarginRight, (float?)MarginTop, (float?)MarginBottom);

        SessionState.PSVariable.Set("PdfDocument", pdfDocument);
        SessionState.PSVariable.Set("Document", document);

        if (PDFContent != null) {
            PDFContent.Invoke();
            document.Close();
            if (Show.IsPresent && File.Exists(FilePath)) {
                System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo(FilePath) { UseShellExecute = true });
            }
        } else {
            WriteObject(pdfDocument);
        }

        SessionState.PSVariable.Remove("Document");
        SessionState.PSVariable.Remove("PdfDocument");
    }
}
