using System.Management.Automation;
using iText.Layout;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFOptions")]
public class CmdletNewPDFOptions : PSCmdlet {
    [Parameter] public double? MarginLeft { get; set; }
    [Parameter] public double? MarginRight { get; set; }
    [Parameter] public double? MarginTop { get; set; }
    [Parameter] public double? MarginBottom { get; set; }

    protected override void ProcessRecord() {
        var document = SessionState.PSVariable.GetValue("Document") as Document;
        if (document != null) {
            PdfOptions.Apply(document, (float?)MarginLeft, (float?)MarginRight, (float?)MarginTop, (float?)MarginBottom);
        }
    }
}
