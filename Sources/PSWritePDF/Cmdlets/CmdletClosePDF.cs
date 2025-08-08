using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Closes an open PDF document.</summary>
/// <para>Disposes the <c>PdfDocument</c> instance and releases associated resources.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>After closing, the document cannot be used further.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Close a document.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Close-PDF -Document $pdf
/// </code>
/// <para>Closes the specified PDF document.</para>
/// </example>
/// <example>
/// <summary>Pipe a document.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>$pdf | Close-PDF
/// </code>
/// <para>Closes the document passed through the pipeline.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet("Close", "PDF")]
public class CmdletClosePDF : PSCmdlet
{
    /// <summary>PDF document to close.</summary>
    [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true)]
    public PdfDocument Document { get; set; } = null!;

    protected override void ProcessRecord()
    {
        Document?.Close();
    }
}
