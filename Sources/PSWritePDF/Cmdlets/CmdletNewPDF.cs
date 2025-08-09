using System;
using System.IO;
using System.Management.Automation;
using iText.Layout;
using iText.Layout.Properties;
using PdfIMO;
using iTextPdf = iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Creates a new PDF document.</summary>
/// <para>Builds a PDF file and optionally executes script block content to populate the document.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Existing files at the target path are overwritten without confirmation.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Create an empty PDF file.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDF -FilePath 'out.pdf'
/// </code>
/// <para>Generates a PDF at the specified path.</para>
/// </example>
/// <example>
/// <summary>Create and display a PDF.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDF -FilePath 'out.pdf' -Show
/// </code>
/// <para>The created PDF opens in the default viewer.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDF")]
public class CmdletNewPDF : PSCmdlet {
    /// <summary>Script block defining PDF content.</summary>
    [Parameter(Position = 0)]
    public ScriptBlock? PDFContent { get; set; }

    /// <summary>Output file path.</summary>
    [Parameter(Mandatory = true)]
    public string FilePath { get; set; } = string.Empty;

    /// <summary>PDF version to use.</summary>
    [Parameter]
    public string? Version { get; set; }

    /// <summary>Left margin in points.</summary>
    [Parameter] public double? MarginLeft { get; set; }
    /// <summary>Right margin in points.</summary>
    [Parameter] public double? MarginRight { get; set; }
    /// <summary>Top margin in points.</summary>
    [Parameter] public double? MarginTop { get; set; }
    /// <summary>Bottom margin in points.</summary>
    [Parameter] public double? MarginBottom { get; set; }
    /// <summary>Initial page size.</summary>
    [Parameter] public PdfPageSize? PageSize { get; set; }
    /// <summary>Rotate the page 90 degrees.</summary>
    [Parameter] public SwitchParameter Rotate { get; set; }
    /// <summary>Show the PDF after creation.</summary>
    [Parameter, Alias("Open")] public SwitchParameter Show { get; set; }

    protected override void ProcessRecord() {
        var filePath = GetUnresolvedProviderPathFromPSPath(FilePath);

        iTextPdf.PdfWriter writer;
        if (!string.IsNullOrEmpty(Version)) {
            var enumName = "PDF_" + Version.Replace('.', '_');
            var pdfVersion = (iTextPdf.PdfVersion)Enum.Parse(typeof(iTextPdf.PdfVersion), enumName, true);
            var props = new iTextPdf.WriterProperties().SetPdfVersion(pdfVersion);
            writer = new iTextPdf.PdfWriter(filePath, props);
        } else {
            writer = new iTextPdf.PdfWriter(filePath);
        }

        var pdfDocument = new iTextPdf.PdfDocument(writer);
        var size = PageSize ?? PdfPageSize.Default;
        var document = PdfPage.AddPage(pdfDocument, size, Rotate.IsPresent, (float?)MarginLeft, (float?)MarginRight, (float?)MarginTop, (float?)MarginBottom);

        SessionState.PSVariable.Set("PdfDocument", pdfDocument);
        SessionState.PSVariable.Set("Document", document);

        if (PDFContent != null) {
            PDFContent.Invoke();
            document.Close();
            if (Show.IsPresent && File.Exists(filePath)) {
                System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo(filePath) { UseShellExecute = true });
            }
        } else {
            WriteObject(pdfDocument);
        }

        SessionState.PSVariable.Remove("Document");
        SessionState.PSVariable.Remove("PdfDocument");
    }
}
