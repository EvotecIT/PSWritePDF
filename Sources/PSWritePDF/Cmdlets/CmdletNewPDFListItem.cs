using System.Management.Automation;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFListItem")]
public class CmdletNewPDFListItem : PSCmdlet {
    [Parameter(Mandatory = true)]
    public string Text { get; set; } = string.Empty;

    protected override void ProcessRecord() {
        WriteObject(Text);
    }
}
