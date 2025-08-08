using System;
using System.Collections.Generic;
using System.IO;
using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Splits a PDF into multiple documents.</summary>
/// <para>Supports splitting by page count, page ranges, or bookmarks.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Existing files in the destination may be overwritten when <c>Force</c> is specified.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Split by page count.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Split-PDF -FilePath 'in.pdf' -OutputFolder './out' -SplitCount 2
/// </code>
/// <para>Creates output files containing two pages each.</para>
/// </example>
/// <example>
/// <summary>Split by page ranges.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Split-PDF -FilePath 'in.pdf' -OutputFolder './out' -PageRange '1-3','4-6'
/// </code>
/// <para>Produces files for the specified ranges.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.Split, "PDF", SupportsShouldProcess = true)]
public class CmdletSplitPDF : PSCmdlet
{
    private const string SplitCountParameterSet = "SplitCount";
    private const string PageRangeParameterSet = "PageRange";
    private const string BookmarkParameterSet = "Bookmark";

    /// <summary>Path to the source PDF.</summary>
    [Parameter(Mandatory = true, ParameterSetName = SplitCountParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = PageRangeParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = BookmarkParameterSet)]
    public string FilePath { get; set; }

    /// <summary>Destination folder for split files.</summary>
    [Parameter(Mandatory = true, ParameterSetName = SplitCountParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = PageRangeParameterSet)]
    [Parameter(Mandatory = true, ParameterSetName = BookmarkParameterSet)]
    public string OutputFolder { get; set; }

    /// <summary>Base name for output files.</summary>
    [Parameter(ParameterSetName = SplitCountParameterSet)]
    [Parameter(ParameterSetName = PageRangeParameterSet)]
    [Parameter(ParameterSetName = BookmarkParameterSet)]
    public string OutputName { get; set; } = "OutputDocument";

    /// <summary>Number of pages per output file.</summary>
    [Parameter(ParameterSetName = SplitCountParameterSet)]
    public int SplitCount { get; set; } = 1;

    /// <summary>Page ranges to extract.</summary>
    [Parameter(ParameterSetName = PageRangeParameterSet)]
    public string[] PageRange { get; set; }

    /// <summary>Bookmark titles that define splits.</summary>
    [Parameter(ParameterSetName = BookmarkParameterSet)]
    public string[] Bookmark { get; set; }

    /// <summary>Ignore document protection.</summary>
    [Parameter(ParameterSetName = SplitCountParameterSet)]
    [Parameter(ParameterSetName = PageRangeParameterSet)]
    [Parameter(ParameterSetName = BookmarkParameterSet)]
    public SwitchParameter IgnoreProtection { get; set; }

    /// <summary>Overwrite existing files without prompting.</summary>
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

