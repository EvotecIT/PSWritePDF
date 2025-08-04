using System.IO;
using iText.Kernel.Pdf;
using iText.Kernel.Utils;

namespace PSWritePDF;

internal sealed class PdfSequentialSplitter : PdfSplitter
{
    private readonly string _destinationFolder;
    private readonly string _outputName;
    private int _order;

    public PdfSequentialSplitter(PdfDocument pdfDocument, string destinationFolder, string outputName) : base(pdfDocument)
    {
        _destinationFolder = destinationFolder;
        _outputName = outputName;
        _order = 0;
    }

    protected override PdfWriter GetNextPdfWriter(PageRange documentPageRange)
    {
        var name = $"{_outputName}{_order++}.pdf";
        var path = Path.Combine(_destinationFolder, name);
        return new PdfWriter(path);
    }
}

