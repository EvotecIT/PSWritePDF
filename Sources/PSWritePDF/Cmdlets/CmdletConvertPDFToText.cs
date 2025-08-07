using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Text;
using iText.Kernel.Pdf;
using iText.Kernel.Pdf.Canvas.Parser;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsData.Convert, "PDFToText")]
[OutputType(typeof(PSObject))]
public class CmdletConvertPDFToText : PSCmdlet
{
    [Parameter(Mandatory = true, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
    [Alias("FullName")]
    public string FilePath { get; set; } = string.Empty;

    [Parameter]
    public int[] Page { get; set; } = Array.Empty<int>();

    [Parameter]
    public PdfExtractionStrategyName ExtractionStrategy { get; set; } = PdfExtractionStrategyName.Simple;

    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

    [Parameter]
    public string? OutFile { get; set; }

    protected override void ProcessRecord()
    {
        if (!File.Exists(FilePath))
        {
            WriteWarning($"Path '{FilePath}' doesn't exist. Terminating.");
            return;
        }

        using var reader = new PdfReader(FilePath);
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
                WriteWarning($"File '{FilePath}' doesn't contain page number {pageNum}. Skipping.");
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
                WriteWarning($"Processing document '{FilePath}' failed with error: {ex.Message}");
            }
        }

        if (!string.IsNullOrWhiteSpace(OutFile))
        {
            try
            {
                var combined = string.Join(Environment.NewLine, collectedTexts);
                File.WriteAllText(OutFile, combined, Encoding.UTF8);
            }
            catch (Exception ex)
            {
                WriteWarning($"Saving file '{OutFile}' failed with error: {ex.Message}");
            }
        }
    }
}

