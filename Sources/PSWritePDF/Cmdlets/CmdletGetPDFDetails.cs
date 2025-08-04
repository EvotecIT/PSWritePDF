using System.Management.Automation;
using iText.Kernel.Pdf;
using iText.Layout;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Get, "PDFDetails")]
[OutputType(typeof(PdfDocumentDetails))]
public class CmdletGetPDFDetails : PSCmdlet
{
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
