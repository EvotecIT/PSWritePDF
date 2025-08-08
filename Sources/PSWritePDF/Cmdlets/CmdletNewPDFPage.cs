using System.Management.Automation;
using iText.Layout;
using PdfIMO;
using iTextPdf = iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Adds a new page to the active PDF document.</summary>
/// <para>Creates a page with optional margins and size, executing a script block for content if supplied.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>This cmdlet requires a document created by <c>New-PDF</c>.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Add a blank page.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFPage
/// </code>
/// <para>Creates a default page.</para>
/// </example>
/// <example>
/// <summary>Add content to a page.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFPage -PageContent { New-PDFText -Text 'Hello' }
/// </code>
/// <para>Inserts a page and writes text on it.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFPage")]
public class CmdletNewPDFPage : PSCmdlet {
    /// <summary>Script block defining page content.</summary>
    [Parameter(Position = 0)]
    public ScriptBlock? PageContent { get; set; }

    /// <summary>Left margin in points.</summary>
    [Parameter] public double? MarginLeft { get; set; }
    /// <summary>Right margin in points.</summary>
    [Parameter] public double? MarginRight { get; set; }
    /// <summary>Top margin in points.</summary>
    [Parameter] public double? MarginTop { get; set; }
    /// <summary>Bottom margin in points.</summary>
    [Parameter] public double? MarginBottom { get; set; }
    /// <summary>Page size to apply.</summary>
    [Parameter] public PdfPageSize? PageSize { get; set; }
    /// <summary>Rotate the page orientation.</summary>
    [Parameter] public SwitchParameter Rotate { get; set; }
    /// <summary>Emit the <c>Document</c> object.</summary>
    [Parameter] public SwitchParameter PassThru { get; set; }

    protected override void ProcessRecord() {
        var pdfDocument = SessionState.PSVariable.GetValue("PdfDocument") as iTextPdf.PdfDocument;
        if (pdfDocument == null) {
            throw new PSInvalidOperationException("PdfDocument variable not found. Call New-PDF first.");
        }
        var size = PageSize ?? PdfPageSize.Default;
        var document = PdfPage.AddPage(pdfDocument, size, Rotate.IsPresent, (float?)MarginLeft, (float?)MarginRight, (float?)MarginTop, (float?)MarginBottom);
        SessionState.PSVariable.Set("Document", document);
        PageContent?.Invoke();
        if (PassThru)
        {
            WriteObject(document);
        }
    }
}
