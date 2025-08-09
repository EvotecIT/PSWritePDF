using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Text;
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas.Parser;

namespace PSWritePDF.Cmdlets;

/// <summary>Converts PDF pages to plain text.</summary>
/// <para>Extracts text from specified pages of a PDF document using iText strategies.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Protected documents may require the <c>IgnoreProtection</c> switch to extract text.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Extract text from a PDF.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Convert-PDFToText -FilePath 'file.pdf'
/// </code>
/// <para>Returns text objects for each page.</para>
/// </example>
/// <example>
/// <summary>Save extracted text to a file.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Convert-PDFToText -FilePath 'file.pdf' -OutFile 'output.txt'
/// </code>
/// <para>Writes combined text to the specified file.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsData.Convert, "PDFToText")]
[OutputType(typeof(PSObject))]
public class CmdletConvertPDFToText : PSCmdlet
{
    /// <summary>Path to the PDF file.</summary>
    [Parameter(Mandatory = true, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
    [Alias("FullName")]
    [ValidateNotNullOrEmpty]
    public string FilePath { get; set; } = string.Empty;

    /// <summary>Pages to extract.</summary>
    [Parameter]
    public int[] Page { get; set; } = Array.Empty<int>();

    /// <summary>Extraction strategy to use.</summary>
    [Parameter]
    public PdfExtractionStrategyName ExtractionStrategy { get; set; } = PdfExtractionStrategyName.Simple;

    /// <summary>Ignore document protection.</summary>
    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

    /// <summary>Optional output file.</summary>
    [Parameter]
    public string? OutFile { get; set; }

    protected override void ProcessRecord()
    {
        var filePath = GetUnresolvedProviderPathFromPSPath(FilePath);
        var outFile = !string.IsNullOrWhiteSpace(OutFile) ? GetUnresolvedProviderPathFromPSPath(OutFile) : null;

        if (!File.Exists(filePath))
        {
            WriteWarning($"Path '{filePath}' doesn't exist. Terminating.");
            return;
        }

        using var reader = new PdfReader(filePath);
        if (IgnoreProtection)
        {
            reader.SetUnethicalReading(true);
        }

        using var pdf = new PdfDocument(reader);
        int pagesCount = pdf.GetNumberOfPages();
        IEnumerable<int> pages = Page.Length == 0 ? Enumerable.Range(1, pagesCount) : Page;

        var collectedTexts = new List<string>();

        foreach (int pageNum in pages)
        {
            if (pageNum < 1 || pageNum > pagesCount)
            {
                WriteWarning($"File '{filePath}' doesn't contain page number {pageNum}. Skipping.");
                continue;
            }

            try
            {
                var page = pdf.GetPage(pageNum);
                var strategy = ExtractionStrategy.ToStrategy();
                string text = PdfTextExtractor.GetTextFromPage(page, strategy);

                var outputObject = new PSObject();
                outputObject.TypeNames.Insert(0, "System.Management.Automation.PSCustomObject");
                outputObject.Properties.Add(new PSNoteProperty("PageNumber", pageNum));
                outputObject.Properties.Add(new PSNoteProperty("Text", text));
                WriteObject(outputObject);
                collectedTexts.Add(text);
            }
            catch (Exception ex)
            {
                WriteWarning($"Processing document '{filePath}' failed with error: {ex.Message}");
            }
        }

        if (!string.IsNullOrWhiteSpace(outFile))
        {
            try
            {
                var combined = string.Join(Environment.NewLine, collectedTexts);
                File.WriteAllText(outFile, combined, Encoding.UTF8);
            }
            catch (Exception ex)
            {
                WriteWarning($"Saving file '{outFile}' failed with error: {ex.Message}");
            }
        }
    }
}

