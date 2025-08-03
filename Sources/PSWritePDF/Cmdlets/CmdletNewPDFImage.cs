using System.Management.Automation;
using iText.Layout;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFImage")]
public class CmdletNewPDFImage : PSCmdlet {
    [Parameter(Mandatory = true)]
    public string ImagePath { get; set; } = string.Empty;
    [Parameter] public int Width { get; set; }
    [Parameter] public int Height { get; set; }
    [Parameter] public PdfColor? BackgroundColor { get; set; }
    [Parameter] public double? BackgroundColorOpacity { get; set; }

    protected override void ProcessRecord() {
        var document = SessionState.PSVariable.GetValue("Document") as Document;
        if (document != null) {
            PdfImage.AddImage(document, ImagePath, Width, Height, BackgroundColor, BackgroundColorOpacity);
        }
    }
}
