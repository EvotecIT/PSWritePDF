using System.Management.Automation;
using iText.Kernel.Pdf;
using iText.Layout;

namespace PSWritePDF.Cmdlets;

/// <summary>Gets descriptive information about a PDF document.</summary>
/// <para>Returns metadata, margins, page sizes, and other details.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The document is inspected but not modified.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Retrieve document details.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFDetails -Document $pdf
/// </code>
/// <para>Outputs a <c>PdfDocumentDetails</c> object.</para>
/// </example>
/// <example>
/// <summary>Pipe from New-PDF.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDF -FilePath 'out.pdf' | Get-PDFDetails
/// </code>
/// <para>Creates a PDF and immediately inspects it.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.Get, "PDFDetails")]
[OutputType(typeof(PdfDocumentDetails))]
public class CmdletGetPDFDetails : PSCmdlet
{
    /// <summary>PDF document to analyze.</summary>
    [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true)]
    public PdfDocument Document { get; set; } = null!;

    protected override void ProcessRecord()
    {
        if (Document is null)
        {
            return;
        }

        var layoutDocument = new Document(Document);
        var details = new PdfDocumentDetails
        {
            Author = Document.GetDocumentInfo().GetAuthor(),
            Creator = Document.GetDocumentInfo().GetCreator(),
            HashCode = Document.GetDocumentInfo().GetHashCode(),
            Keywords = Document.GetDocumentInfo().GetKeywords(),
            Producer = Document.GetDocumentInfo().GetProducer(),
            Subject = Document.GetDocumentInfo().GetSubject(),
            Title = Document.GetDocumentInfo().GetTitle(),
            Trapped = Document.GetDocumentInfo().GetTrapped()?.ToString(),
            Version = Document.GetPdfVersion(),
            PagesNumber = Document.GetNumberOfPages(),
            MarginLeft = layoutDocument.GetLeftMargin(),
            MarginRight = layoutDocument.GetRightMargin(),
            MarginBottom = layoutDocument.GetBottomMargin(),
            MarginTop = layoutDocument.GetTopMargin()
        };

        for (int i = 1; i <= details.PagesNumber; i++)
        {
            var page = Document.GetPage(i);
            var pageSize = page.GetPageSizeWithRotation();
            var height = (int)pageSize.GetHeight();
            var width = (int)pageSize.GetWidth();
            var (size, rotated) = PdfPageSizeLookup.Get(height, width);
            details.Pages[i] = new PdfPageDetails
            {
                Height = height,
                Width = width,
                Rotation = page.GetRotation(),
                Size = size,
                Rotated = rotated
            };
        }

        WriteObject(details);
    }
}
