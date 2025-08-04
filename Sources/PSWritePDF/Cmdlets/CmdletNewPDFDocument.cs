using System.Management.Automation;
using iText.Kernel.Pdf;
using iText.Layout;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFDocument")]
public class CmdletNewPDFDocument : PSCmdlet
{
    [Parameter(Mandatory = true)]
    public PdfDocument PDF { get; set; } = null!;

    protected override void ProcessRecord()
    {
        var document = new Document(PDF);
        WriteObject(document);
    }
}
