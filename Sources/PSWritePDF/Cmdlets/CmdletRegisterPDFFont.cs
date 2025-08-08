using System;
using System.Collections.Generic;
using System.IO;
using System.Management.Automation;
using iText.IO.Font;
using iText.Kernel.Font;

namespace PSWritePDF.Cmdlets;

/// <summary>Registers a font for use in PDF generation.</summary>
/// <para>Adds a font to the session cache and optionally sets it as default.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Font files must exist on disk; missing paths trigger warnings.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Register a font.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Register-PDFFont -FontName MyFont -FontPath 'c:\fonts\my.ttf'
/// </code>
/// <para>Makes the font available for later use.</para>
/// </example>
/// <example>
/// <summary>Register and set as default.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Register-PDFFont -FontName MyFont -FontPath 'c:\fonts\my.ttf' -Default
/// </code>
/// <para>Subsequent text uses this font automatically.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsLifecycle.Register, "PDFFont")]
public class CmdletRegisterPDFFont : PSCmdlet
{
    /// <summary>Name used to reference the font.</summary>
    [Parameter(Mandatory = true)]
    public string FontName { get; set; } = string.Empty;

    /// <summary>Path to the font file.</summary>
    [Parameter(Mandatory = true)]
    public string FontPath { get; set; } = string.Empty;

    /// <summary>Optional encoding for the font.</summary>
    [Parameter]
    public PdfFontEncoding Encoding { get; set; } = PdfFontEncoding.None;

    /// <summary>Embedding strategy for the font.</summary>
    [Parameter]
    public PdfFontFactory.EmbeddingStrategy EmbeddingStrategy { get; set; } = PdfFontFactory.EmbeddingStrategy.PREFER_EMBEDDED;

    /// <summary>Cache the font for reuse.</summary>
    [Parameter]
    public SwitchParameter Cached { get; set; }

    /// <summary>Set the font as default.</summary>
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
