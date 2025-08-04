using System;
using System.IO;
using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Split, "PDF")]
public class CmdletSplitPDF : PSCmdlet
{
    [Parameter(Mandatory = true)]
    public string FilePath { get; set; }

    [Parameter(Mandatory = true)]
    public string OutputFolder { get; set; }

    [Parameter]
    public string OutputName { get; set; } = "OutputDocument";

    [Parameter]
    public int SplitCount { get; set; } = 1;

    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

    protected override void ProcessRecord()
    {
        if (SplitCount == 0)
        {
            WriteWarning("SplitCount is 0. Terminating.");
            return;
        }

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
            using var reader = new PdfReader(FilePath);
            if (IgnoreProtection)
            {
                reader.SetUnethicalReading(true);
            }

            using var document = new PdfDocument(reader);
            var splitter = new PdfSequentialSplitter(document, OutputFolder, OutputName);
            var documents = splitter.SplitByPageCount(SplitCount);

            foreach (var doc in documents)
            {
                doc.Close();
            }
        }
        catch (Exception ex)
        {
            WriteWarning($"Error has occurred: {ex.Message}");
        }
    }
}

