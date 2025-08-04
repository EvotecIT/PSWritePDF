using System;
using System.IO;
using System.Management.Automation;
using iText.Kernel.Pdf;
using iText.Kernel.Utils;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsData.Merge, "PDF")]
[Alias("Merge-PDF")]
public class CmdletMergePDF : PSCmdlet
{
    [Parameter(Mandatory = true)]
    public string[] InputFile { get; set; }

    [Parameter(Mandatory = true)]
    public string OutputFile { get; set; }

    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

    protected override void ProcessRecord()
    {
        if (InputFile == null || InputFile.Length == 0)
        {
            WriteWarning("No input files provided. Terminating.");
            return;
        }

        try
        {
            using var writer = new PdfWriter(OutputFile);
            using var pdf = new PdfDocument(writer);
            var merger = new PdfMerger(pdf);

            foreach (var file in InputFile)
            {
                if (!File.Exists(file))
                {
                    WriteWarning($"File '{file}' doesn't exist. Skipping.");
                    continue;
                }

                try
                {
                    using var reader = new PdfReader(file);
                    if (IgnoreProtection)
                    {
                        reader.SetUnethicalReading(true);
                    }

                    using var source = new PdfDocument(reader);
                    merger.Merge(source, 1, source.GetNumberOfPages());
                }
                catch (Exception ex)
                {
                    WriteWarning($"Processing document '{file}' failed with error: {ex.Message}");
                }
            }
        }
        catch (Exception ex)
        {
            WriteWarning($"Saving document '{OutputFile}' failed with error: {ex.Message}");
        }
    }
}

