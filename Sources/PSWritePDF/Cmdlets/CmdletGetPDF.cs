using System;
using System.IO;
using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Get, "PDF")]
[OutputType(typeof(PdfDocument))]
public class CmdletGetPDF : PSCmdlet
{
    [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true)]
    public string FilePath { get; set; } = null!;

    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

    protected override void ProcessRecord()
    {
        if (string.IsNullOrWhiteSpace(FilePath) || !File.Exists(FilePath))
        {
            WriteWarning($"Get-PDF - File '{FilePath}' not found.");
            return;
        }

        try
        {
            var pdfReader = new PdfReader(FilePath);
            if (IgnoreProtection)
            {
                pdfReader.SetUnethicalReading(true);
            }
            var document = new PdfDocument(pdfReader);
            WriteObject(document);
        }
        catch (Exception ex)
        {
            WriteWarning($"Get-PDF - Processing document {FilePath} failed with error: {ex.Message}");
        }
    }
}
