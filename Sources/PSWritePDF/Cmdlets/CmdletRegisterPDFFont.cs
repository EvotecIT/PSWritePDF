using System;
using System.Collections.Generic;
using System.IO;
using System.Management.Automation;
using iText.IO.Font;
using iText.Kernel.Font;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsLifecycle.Register, "PDFFont")]
public class CmdletRegisterPDFFont : PSCmdlet
{
    [Parameter(Mandatory = true)]
    public string FontName { get; set; } = string.Empty;

    [Parameter(Mandatory = true)]
    public string FontPath { get; set; } = string.Empty;

    [Parameter]
    public PdfFontEncoding Encoding { get; set; } = PdfFontEncoding.None;

    [Parameter]
    public PdfFontFactory.EmbeddingStrategy EmbeddingStrategy { get; set; } = PdfFontFactory.EmbeddingStrategy.PREFER_EMBEDDED;

    [Parameter]
    public SwitchParameter Cached { get; set; }

    [Parameter]
    public SwitchParameter Default { get; set; }

    protected override void BeginProcessing()
    {
        if (SessionState.PSVariable.GetValue("Fonts") is not IDictionary<string, PdfFont>)
        {
            SessionState.PSVariable.Set("Fonts", new Dictionary<string, PdfFont>());
        }
    }

    protected override void ProcessRecord()
    {
        var fonts = (IDictionary<string, PdfFont>)SessionState.PSVariable.GetValue("Fonts");
        if (!File.Exists(FontPath))
        {
            var ex = new FileNotFoundException($"Font path '{FontPath}' does not exist.");
            if (MyInvocation.BoundParameters.ContainsKey("ErrorAction") &&
                MyInvocation.BoundParameters["ErrorAction"].ToString() == "Stop")
            {
                ThrowTerminatingError(new ErrorRecord(ex, "RegisterPDFFont", ErrorCategory.ObjectNotFound, FontPath));
            }
            else
            {
                WriteWarning($"Register-PDFFont - Font path does not exist. Path: {FontPath}");
                return;
            }
        }

        try
        {
            PdfFont font;
            var encodingString = Encoding.ToEncodingString();
            if (!string.IsNullOrEmpty(encodingString))
            {
                font = PdfFontFactory.CreateFont(FontPath, encodingString, EmbeddingStrategy, Cached.IsPresent);
            }
            else
            {
                font = PdfFontFactory.CreateFont(FontPath, EmbeddingStrategy);
            }
            fonts[FontName] = font;
            SessionState.PSVariable.Set("Fonts", fonts);
            if ((Default.IsPresent || fonts.Count == 1) && fonts[FontName] != null)
            {
                SessionState.PSVariable.Set("DefaultFont", fonts[FontName]);
            }
            WriteObject(font);
        }
        catch (Exception ex)
        {
            if (MyInvocation.BoundParameters.ContainsKey("ErrorAction") &&
                MyInvocation.BoundParameters["ErrorAction"].ToString() == "Stop")
            {
                ThrowTerminatingError(new ErrorRecord(ex, "RegisterPDFFont", ErrorCategory.WriteError, FontPath));
            }
            else
            {
                WriteWarning($"Register-PDFFont - Font registration failed. Error: {ex.Message}");
            }
        }
    }
}
