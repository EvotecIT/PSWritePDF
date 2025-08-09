using System;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace PSWritePDF.Cmdlets;

/// <summary>Converts HTML content to a PDF file.</summary>
/// <para>Accepts HTML from a URI, string content, or file and writes a PDF to disk.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Existing output files are overwritten when <c>-Force</c> is specified.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Convert from URI.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Convert-HTMLToPDF -Uri 'https://example.com' -OutputFilePath 'page.pdf'
/// </code>
/// <para>Downloads the page and saves it as PDF.</para>
/// </example>
/// <example>
/// <summary>Convert from file with CSS.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Convert-HTMLToPDF -FilePath 'index.html' -CssFilePath 'style.css' -OutputFilePath 'out.pdf'
/// </code>
/// <para>Applies the specified CSS and writes the PDF.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsData.Convert, "HTMLToPDF", DefaultParameterSetName = ParameterSetNames.Uri, SupportsShouldProcess = true)]
public class CmdletConvertHTMLToPDF : AsyncPSCmdlet
{
    private static class ParameterSetNames
    {
        public const string Uri = "Uri";
        public const string Content = "Content";
        public const string File = "File";
    }

    /// <summary>URI of the HTML page.</summary>
    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.Uri)]
    public string Uri { get; set; }

    /// <summary>Raw HTML content.</summary>
    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.Content)]
    public string Content { get; set; }

    /// <summary>Path to an HTML file.</summary>
    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.File)]
    [ValidateNotNullOrEmpty]
    public string FilePath { get; set; }

    /// <summary>Output PDF path.</summary>
    [Parameter(Mandatory = true)]
    [ValidateNotNullOrEmpty]
    public string OutputFilePath { get; set; }

    /// <summary>Open the PDF after creation.</summary>
    [Parameter]
    public SwitchParameter Open { get; set; }

    /// <summary>Overwrite existing files.</summary>
    [Parameter]
    public SwitchParameter Force { get; set; }

    /// <summary>Base URI for relative links.</summary>
    [Parameter]
    public string BaseUri { get; set; }

    /// <summary>Paths to CSS files to include.</summary>
    [Parameter]
    public string[] CssFilePath { get; set; }

    protected override async Task ProcessRecordAsync()
    {
        string html = Content;

        if (ParameterSetName == ParameterSetNames.File)
        {
            if (!File.Exists(FilePath))
            {
                WriteWarning($"File '{FilePath}' doesn't exist.");
                return;
            }
            html = File.ReadAllText(FilePath);
        }
        else if (ParameterSetName == ParameterSetNames.Uri)
        {
            try
            {
                using var client = new HttpClient();
                html = await client.GetStringAsync(Uri).ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                WriteWarning($"Failed to download '{Uri}': {ex.Message}");
                return;
            }
        }

        if (string.IsNullOrEmpty(html))
        {
            return;
        }

        if (File.Exists(OutputFilePath) && !Force.IsPresent)
        {
            WriteWarning($"File '{OutputFilePath}' already exists. Use -Force to overwrite.");
            return;
        }

        if (!ShouldProcess(OutputFilePath, "Convert HTML to PDF"))
        {
            return;
        }

        try
        {
            if (CssFilePath != null && CssFilePath.Length > 0)
            {
                var cssContent = new StringBuilder();
                foreach (var css in CssFilePath.Where(File.Exists))
                {
                    cssContent.AppendLine(File.ReadAllText(css));
                }
                foreach (var missing in CssFilePath.Where(p => !File.Exists(p)))
                {
                    WriteWarning($"CSS file '{missing}' doesn't exist.");
                }
                if (cssContent.Length > 0)
                {
                    var styleTag = $"<style>{cssContent}</style>";
                    var headCloseIndex = html.IndexOf("</head>", StringComparison.OrdinalIgnoreCase);
                    html = headCloseIndex >= 0
                        ? html.Insert(headCloseIndex, styleTag)
                        : styleTag + html;
                }
            }

            using var fs = new FileStream(OutputFilePath, FileMode.Create, FileAccess.Write);
            var properties = new iText.Html2pdf.ConverterProperties();
            if (!string.IsNullOrEmpty(BaseUri))
            {
                properties.SetBaseUri(BaseUri);
            }
            iText.Html2pdf.HtmlConverter.ConvertToPdf(html, fs, properties);
            if (Open.IsPresent)
            {
                var psi = new System.Diagnostics.ProcessStartInfo
                {
                    FileName = OutputFilePath,
                    UseShellExecute = true,
                };
                System.Diagnostics.Process.Start(psi);
            }

            if (ShouldProcess(OutputFilePath, "Write output"))
            {
                WriteObject(OutputFilePath);
            }
        }
        catch (Exception ex)
        {
            WriteWarning($"Error converting to PDF: {ex.Message}");
        }
    }
}

