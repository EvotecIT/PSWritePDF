using System.Collections.Generic;
using System.IO;
using System.Linq;
using iText.Kernel.Pdf;
using iText.Kernel.Utils;

namespace PSWritePDF;

internal sealed class PdfSequentialSplitter : PdfSplitter
{
    private readonly string _destinationFolder;
    private readonly string _outputName;
    private readonly bool _overwrite;
    private int _order;
    public IList<string> OutputFiles { get; }

    public PdfSequentialSplitter(PdfDocument pdfDocument, string destinationFolder, string outputName, bool overwrite) : base(pdfDocument)
    {
        _destinationFolder = destinationFolder;
        _outputName = outputName;
        _overwrite = overwrite;
        _order = 0;
        OutputFiles = new List<string>();
    }

    protected override PdfWriter GetNextPdfWriter(PageRange documentPageRange)
    {
        var name = $"{_outputName}{_order++}.pdf";
        var path = Path.Combine(_destinationFolder, name);
        if (File.Exists(path))
        {
            if (!_overwrite)
            {
                throw new IOException($"File '{path}' already exists. Use -Force to overwrite.");
            }
            File.Delete(path);
        }

        OutputFiles.Add(path);
        return new PdfWriter(path);
    }

    public IList<PdfDocument> SplitByPageRanges(IEnumerable<string> pageRanges)
    {
        var ranges = pageRanges.Select(r => new PageRange(r)).ToList();
        return ExtractPageRanges(ranges);
    }

    public IList<PdfDocument> SplitByBookmarks(IEnumerable<string> bookmarks)
    {
        return SplitByOutlines(bookmarks.ToList());
    }
}

