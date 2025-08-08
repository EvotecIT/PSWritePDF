using System;
using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Applies metadata to a PDF document.</summary>
/// <para>Sets title, author, keywords, and optional creation/modification dates.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Changes affect the in-memory document and require saving to persist.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Add basic metadata.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFInfo -PDF $pdf -Title 'Report'
/// </code>
/// <para>Sets the document title.</para>
/// </example>
/// <example>
/// <summary>Add creation date.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFInfo -PDF $pdf -AddCreationDate
/// </code>
/// <para>Stores the current time as the creation date.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFInfo")]
public class CmdletNewPDFInfo : PSCmdlet
{
    /// <summary>PDF document to modify.</summary>
    [Parameter(Mandatory = true)]
    public PdfDocument PDF { get; set; } = null!;

    /// <summary>Document title.</summary>
    [Parameter] public string? Title { get; set; }
    /// <summary>Document author.</summary>
    [Parameter] public string? Author { get; set; }
    /// <summary>Document creator.</summary>
    [Parameter] public string? Creator { get; set; }
    /// <summary>Document subject.</summary>
    [Parameter] public string? Subject { get; set; }
    /// <summary>Keywords to add.</summary>
    [Parameter] public string[]? Keywords { get; set; }
    /// <summary>Add creation date metadata.</summary>
    [Parameter] public SwitchParameter AddCreationDate { get; set; }
    /// <summary>Add modification date metadata.</summary>
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
