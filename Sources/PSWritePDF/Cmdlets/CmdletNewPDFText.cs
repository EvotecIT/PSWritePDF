using System;
using System.Management.Automation;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

/// <summary>Adds a paragraph of text to the current PDF document.</summary>
/// <para>Creates an iText <c>Paragraph</c> with formatting options and writes it to the active document.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The paragraph is added only if a document is stored in the <c>Document</c> session variable.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Add basic text.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFText -Text 'Hello World'
/// </code>
/// <para>Inserts a paragraph with the specified text.</para>
/// </example>
/// <example>
/// <summary>Use custom font and size.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFText -Text 'Hello' -FontSize 18 -FontBold $true
/// </code>
/// <para>Creates emphasized text in the document.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFText")]
public class CmdletNewPDFText : PSCmdlet {
    /// <summary>Text lines to add.</summary>
    [Parameter(Mandatory = true)]
    public string[] Text { get; set; } = Array.Empty<string>();

    /// <summary>Fonts for each line.</summary>
    [Parameter] public PdfFontName[]? Font { get; set; }
    /// <summary>Font colors.</summary>
    [Parameter] public PdfColor[]? FontColor { get; set; }
    /// <summary>Apply bold style per line.</summary>
    [Parameter] public bool?[]? FontBold { get; set; }
    /// <summary>Font size in points.</summary>
    [Parameter] public int? FontSize { get; set; }
    /// <summary>Alignment of the text.</summary>
    [Parameter] public TextAlignment? TextAlignment { get; set; }
    /// <summary>Top margin in points.</summary>
    [Parameter] public double? MarginTop { get; set; } = 2;
    /// <summary>Bottom margin in points.</summary>
    [Parameter] public double? MarginBottom { get; set; } = 2;
    /// <summary>Left margin in points.</summary>
    [Parameter] public double? MarginLeft { get; set; }
    /// <summary>Right margin in points.</summary>
    [Parameter] public double? MarginRight { get; set; }

    protected override void ProcessRecord() {
        var paragraph = PdfText.CreateParagraph(
            Text,
            Font,
            FontColor,
            FontSize,
            TextAlignment,
            (float?)MarginTop,
            (float?)MarginBottom,
            (float?)MarginLeft,
            (float?)MarginRight);

        var document = SessionState.PSVariable.GetValue("Document") as Document;
        document?.Add(paragraph);
        WriteObject(paragraph);
    }
}
