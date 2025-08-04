using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet("Close", "PDF")]
public class CmdletClosePDF : PSCmdlet
{
    [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true)]
    public PdfDocument Document { get; set; } = null!;

    protected override void ProcessRecord()
    {
        Document?.Close();
    }
}
