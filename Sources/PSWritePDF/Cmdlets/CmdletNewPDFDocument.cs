using System.Management.Automation;
using iText.Kernel.Pdf;
using iText.Layout;

namespace PSWritePDF.Cmdlets;

/// <summary>Wraps a PDF document in an iText <c>Document</c>.</summary>
/// <para>Creates a layout <c>Document</c> object for further content operations.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The caller is responsible for closing the document.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Create a document object.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFDocument -PDF $pdf
/// </code>
/// <para>Returns an iText layout document.</para>
/// </example>
/// <example>
/// <summary>Store document for later use.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>$doc = New-PDFDocument -PDF $pdf
/// </code>
/// <para>Assigns the document to a variable.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFDocument")]
public class CmdletNewPDFDocument : PSCmdlet
{
    /// <summary>Underlying PDF document.</summary>
    [Parameter(Mandatory = true)]
    public PdfDocument PDF { get; set; } = null!;

    protected override void ProcessRecord()
    {
        var document = new Document(PDF);
        WriteObject(document);
    }
}
