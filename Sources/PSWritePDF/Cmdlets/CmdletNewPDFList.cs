using System.Collections.Generic;
using System.Management.Automation;
using iText.Layout;
using iText.Layout.Properties;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

/// <summary>Adds a list of items to the current PDF document.</summary>
/// <para>Creates a bullet or numbered list using provided items or a script block.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The list is only added if a document is available in the session.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Create a list from strings.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFList -Items 'one','two'
/// </code>
/// <para>Adds a simple bullet list.</para>
/// </example>
/// <example>
/// <summary>Generate list via script block.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFList -ListItems { 1..3 }
/// </code>
/// <para>Creates a list using numbers returned from the script block.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFList")]
public class CmdletNewPDFList : PSCmdlet {
    /// <summary>Script block producing list items.</summary>
    [Parameter(Position = 0, ParameterSetName = "ScriptBlock")]
    public ScriptBlock? ListItems { get; set; }
    /// <summary>Items to include in the list.</summary>
    [Parameter(Position = 0, ParameterSetName = "Items")]
    public string[]? Items { get; set; }
    /// <summary>List indentation in points.</summary>
    [Parameter] public double? Indent { get; set; }
    /// <summary>Symbol style for the list.</summary>
    [Parameter] public ListSymbol Symbol { get; set; } = ListSymbol.Hyphen;
    /// <summary>Font for list items.</summary>
    [Parameter] public PdfFontName? Font { get; set; }
    /// <summary>Color of the font.</summary>
    [Parameter] public PdfColor? FontColor { get; set; }
    /// <summary>Font size.</summary>
    [Parameter] public int? FontSize { get; set; }
    /// <summary>Text alignment of the list.</summary>
    [Parameter] public TextAlignment? TextAlignment { get; set; }
    /// <summary>Top margin.</summary>
    [Parameter] public double? MarginTop { get; set; }
    /// <summary>Bottom margin.</summary>
    [Parameter] public double? MarginBottom { get; set; }
    /// <summary>Left margin.</summary>
    [Parameter] public double? MarginLeft { get; set; }
    /// <summary>Right margin.</summary>
    [Parameter] public double? MarginRight { get; set; }

    protected override void ProcessRecord() {
        var items = new List<string>();
        if (Items != null) {
            items.AddRange(Items);
        } else if (ListItems != null) {
            foreach (var result in ListItems.Invoke()) {
                if (result != null) {
                    items.Add(result.ToString()!);
                }
            }
        }

        var document = SessionState.PSVariable.GetValue("Document") as Document;
        if (document != null) {
            PdfList.AddList(
                document,
                items,
                (float?)Indent,
                Symbol,
                Font,
                FontColor,
                FontSize,
                TextAlignment,
                (float?)MarginTop,
                (float?)MarginBottom,
                (float?)MarginLeft,
                (float?)MarginRight);
        }
    }
}
