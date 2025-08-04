using System;
using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFInfo")]
public class CmdletNewPDFInfo : PSCmdlet
{
    [Parameter(Mandatory = true)]
    public PdfDocument PDF { get; set; } = null!;

    [Parameter] public string? Title { get; set; }
    [Parameter] public string? Author { get; set; }
    [Parameter] public string? Creator { get; set; }
    [Parameter] public string? Subject { get; set; }
    [Parameter] public string[]? Keywords { get; set; }
    [Parameter] public SwitchParameter AddCreationDate { get; set; }
    [Parameter] public SwitchParameter AddModificationDate { get; set; }

    protected override void ProcessRecord()
    {
        try
        {
            var info = PDF.GetDocumentInfo();
            if (!string.IsNullOrEmpty(Title)) info.SetTitle(Title);
            if (AddCreationDate.IsPresent) info.AddCreationDate();
            if (AddModificationDate.IsPresent) info.AddModDate();
            if (!string.IsNullOrEmpty(Author)) info.SetAuthor(Author);
            if (!string.IsNullOrEmpty(Creator)) info.SetCreator(Creator);
            if (!string.IsNullOrEmpty(Subject)) info.SetSubject(Subject);
            if (Keywords != null && Keywords.Length > 0) info.SetKeywords(string.Join(",", Keywords));
            WriteObject(info);
        }
        catch (Exception ex)
        {
            if (MyInvocation.BoundParameters.ContainsKey("ErrorAction") &&
                MyInvocation.BoundParameters["ErrorAction"].ToString() == "Stop")
            {
                ThrowTerminatingError(new ErrorRecord(ex, "NewPDFInfo", ErrorCategory.WriteError, PDF));
            }
            else
            {
                WriteWarning($"New-PDFInfo - Error: {ex.Message}");
            }
        }
    }
}
