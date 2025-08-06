using System;
using System.IO;
using System.Management.Automation;
using System.Net.Http;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsData.Convert, "HTMLToPDF", DefaultParameterSetName = ParameterSetNames.Uri, SupportsShouldProcess = true)]
public class CmdletConvertHTMLToPDF : PSCmdlet
{
    private static class ParameterSetNames
    {
        public const string Uri = "Uri";
        public const string Content = "Content";
        public const string File = "File";
    }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.Uri)]
    public string Uri { get; set; }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.Content)]
    public string Content { get; set; }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.File)]
    public string FilePath { get; set; }

    [Parameter(Mandatory = true)]
    public string OutputFilePath { get; set; }

    [Parameter]
    public SwitchParameter Open { get; set; }

    [Parameter]
    public SwitchParameter Force { get; set; }

    protected override void ProcessRecord()
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
                html = client.GetStringAsync(Uri).GetAwaiter().GetResult();
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
            using var fs = new FileStream(OutputFilePath, FileMode.Create, FileAccess.Write);
            iText.Html2pdf.HtmlConverter.ConvertToPdf(html, fs);
            if (Open.IsPresent)
            {
                var psi = new System.Diagnostics.ProcessStartInfo
                {
                    FileName = OutputFilePath,
                    UseShellExecute = true,
                };
                System.Diagnostics.Process.Start(psi);
            }

            WriteObject(OutputFilePath);
        }
        catch (Exception ex)
        {
            WriteWarning($"Error converting to PDF: {ex.Message}");
        }
    }
}

