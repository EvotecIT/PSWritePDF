using System;
using System.IO;
using System.Linq;
using System.Management.Automation;
using iText.Kernel.Pdf;
using iText.Kernel.Utils;

namespace PSWritePDF.Cmdlets;

/// <summary>Merges multiple PDF files into one.</summary>
/// <para>Combines input PDFs in order and saves the result to a specified file.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Existing output files are overwritten without prompt.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Merge two files.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Merge-PDF -InputFile 'a.pdf','b.pdf' -OutputFile 'merged.pdf'
/// </code>
/// <para>Creates a single PDF containing pages from both inputs.</para>
/// </example>
/// <example>
/// <summary>Merge ignoring protection.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Merge-PDF -InputFile $files -OutputFile 'all.pdf' -IgnoreProtection
/// </code>
/// <para>Processes protected files as well.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsData.Merge, "PDF")]
public class CmdletMergePDF : PSCmdlet
{
    /// <summary>Paths to PDF files to merge.</summary>
    [Parameter(Mandatory = true)]
    public string[] InputFile { get; set; }

    /// <summary>Path for the merged output.</summary>
    [Parameter(Mandatory = true)]
    public string OutputFile { get; set; }

    /// <summary>Ignore protection on input files.</summary>
    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

    protected override void ProcessRecord()
    {
        if (InputFile == null || InputFile.Length == 0)
        {
            WriteWarning("No input files provided. Terminating.");
            return;
        }

        var inputFiles = InputFile.Select(f => GetUnresolvedProviderPathFromPSPath(f)).ToArray();
        var outputFile = GetUnresolvedProviderPathFromPSPath(OutputFile);

        try
        {
            using var writer = new PdfWriter(outputFile);
            using var pdf = new PdfDocument(writer);
            var merger = new PdfMerger(pdf);

            foreach (var file in inputFiles)
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
            WriteWarning($"Saving document '{outputFile}' failed with error: {ex.Message}");
        }
    }
}

