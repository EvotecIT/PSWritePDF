using System.Management.Automation;
using iText.Layout;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

/// <summary>Creates or applies PDF margin options.</summary>
/// <para>Modifies margins of the current document or returns an options object.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>No changes are made if no document is open.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Set margins on active document.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFOptions -MarginTop 20 -MarginBottom 20
/// </code>
/// <para>Applies new margins to the current document.</para>
/// </example>
/// <example>
/// <summary>Return options object.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>$opts = New-PDFOptions -MarginLeft 10 -MarginRight 10 -PassThru
/// </code>
/// <para>Creates a <c>PdfDocumentOptions</c> instance for later use.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFOptions")]
public class CmdletNewPDFOptions : PSCmdlet
{
    /// <summary>Left margin in points.</summary>
    [Parameter] public double? MarginLeft { get; set; }
    /// <summary>Right margin in points.</summary>
    [Parameter] public double? MarginRight { get; set; }
    /// <summary>Top margin in points.</summary>
    [Parameter] public double? MarginTop { get; set; }
    /// <summary>Bottom margin in points.</summary>
    [Parameter] public double? MarginBottom { get; set; }
    /// <summary>Return the updated document or options.</summary>
    [Parameter] public SwitchParameter PassThru { get; set; }

    protected override void ProcessRecord()
    {
        var document = SessionState.PSVariable.GetValue("Document") as Document;
        if (document != null)
        {
            PdfOptions.Apply(document, (float?)MarginLeft, (float?)MarginRight, (float?)MarginTop, (float?)MarginBottom);
            if (PassThru)
            {
                WriteObject(document);
            }
        }
        else if (PassThru)
        {
            var options = new PdfDocumentOptions
            {
                MarginLeft = (float?)MarginLeft,
                MarginRight = (float?)MarginRight,
                MarginTop = (float?)MarginTop,
                MarginBottom = (float?)MarginBottom
            };
            WriteObject(options);
        }
    }
}
