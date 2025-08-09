using System;
using System.IO;
using System.Management.Automation;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Opens an existing PDF file.</summary>
/// <para>Returns an iText <c>PdfDocument</c> for further processing.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The caller must dispose the returned document.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Load a PDF.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDF -FilePath 'doc.pdf'
/// </code>
/// <para>Returns a <c>PdfDocument</c> instance.</para>
/// </example>
/// <example>
/// <summary>Ignore protection.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDF -FilePath 'doc.pdf' -IgnoreProtection
/// </code>
/// <para>Opens a protected PDF for reading.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.Get, "PDF")]
[OutputType(typeof(PdfDocument))]
public class CmdletGetPDF : PSCmdlet
{
    /// <summary>Path to the PDF file.</summary>
    [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true)]
    [ValidateNotNullOrEmpty]
    public string FilePath { get; set; } = null!;

    /// <summary>Ignore document protection.</summary>
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
