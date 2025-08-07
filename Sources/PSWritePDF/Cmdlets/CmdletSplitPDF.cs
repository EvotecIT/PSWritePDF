using System;
using System.Collections.Generic;
using System.IO;
using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Split, "PDF", SupportsShouldProcess = true)]
public class CmdletSplitPDF : PSCmdlet
{
    private const string SplitCountParameterSet = "SplitCount";
    private const string PageRangeParameterSet = "PageRange";
    private const string BookmarkParameterSet = "Bookmark";

    [Parameter(Mandatory = true, ParameterSetName = SplitCountParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = PageRangeParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = BookmarkParameterSet)]
    public string FilePath { get; set; }

    [Parameter(Mandatory = true, ParameterSetName = SplitCountParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = PageRangeParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = BookmarkParameterSet)]
    public string OutputFolder { get; set; }

    [Parameter(ParameterSetName = SplitCountParameterSet)]
    [Parameter(ParameterSetName = PageRangeParameterSet)]
    [Parameter(ParameterSetName = BookmarkParameterSet)]
    public string OutputName { get; set; } = "OutputDocument";

    [Parameter(ParameterSetName = SplitCountParameterSet)]
    public int SplitCount { get; set; } = 1;

    [Parameter(ParameterSetName = PageRangeParameterSet)]
    public string[] PageRange { get; set; }

    [Parameter(ParameterSetName = BookmarkParameterSet)]
    public string[] Bookmark { get; set; }

    [Parameter(ParameterSetName = SplitCountParameterSet)]
    [Parameter(ParameterSetName = PageRangeParameterSet)]
    [Parameter(ParameterSetName = BookmarkParameterSet)]
    public SwitchParameter IgnoreProtection { get; set; }

    [Parameter(ParameterSetName = SplitCountParameterSet)]
    [Parameter(ParameterSetName = PageRangeParameterSet)]
    [Parameter(ParameterSetName = BookmarkParameterSet)]
    public SwitchParameter Force { get; set; }

    protected override void ProcessRecord()
    {
        if (!File.Exists(FilePath))
        {
            WriteWarning($"Path '{FilePath}' doesn't exist. Terminating.");
            return;
        }

        if (!Directory.Exists(OutputFolder))
        {
            WriteWarning($"Destination folder '{OutputFolder}' doesn't exist. Terminating.");
            return;
        }

        try
        {
            if (!ShouldProcess(FilePath, $"Split into '{OutputFolder}'"))
            {
                return;
            }

            using var reader = new PdfReader(FilePath);
            if (IgnoreProtection)
            {
                reader.SetUnethicalReading(true);
            }

            using var document = new PdfDocument(reader);
            var splitter = new PdfSequentialSplitter(document, OutputFolder, OutputName, Force.IsPresent);
            IList<PdfDocument> documents;

            if (ParameterSetName == SplitCountParameterSet)
            {
                if (SplitCount == 0)
                {
                    WriteWarning("SplitCount is 0. Terminating.");
                    return;
                }

                documents = splitter.SplitByPageCount(SplitCount);
            }
            else if (ParameterSetName == PageRangeParameterSet)
            {
                documents = splitter.SplitByPageRanges(PageRange);
            }
            else
            {
                documents = splitter.SplitByBookmarks(Bookmark);
            }

            foreach (var doc in documents)
            {
                doc.Close();
            }

            WriteObject(splitter.OutputFiles, true);
        }
        catch (Exception ex)
        {
            WriteWarning($"Error has occurred: {ex.Message}");
        }
    }
}

