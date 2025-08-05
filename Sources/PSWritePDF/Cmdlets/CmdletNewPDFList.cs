using System;
using System.Collections.Generic;
using System.Management.Automation;
using iText.Kernel.Font;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFList")]
public class CmdletNewPDFList : PSCmdlet {
    [Parameter(Position = 0, ParameterSetName = "ScriptBlock")]
    public ScriptBlock? ListItems { get; set; }
    [Parameter(ParameterSetName = "Items")]
    public string[]? Items { get; set; }
    [Parameter] public double? Indent { get; set; }
    [Parameter] public ListSymbol Symbol { get; set; } = ListSymbol.Hyphen;
    [Parameter] public string? Font { get; set; }
    [Parameter] public PdfColor? FontColor { get; set; }
    [Parameter] public int? FontSize { get; set; }
    [Parameter] public TextAlignment? TextAlignment { get; set; }
    [Parameter] public double? MarginTop { get; set; }
    [Parameter] public double? MarginBottom { get; set; }
    [Parameter] public double? MarginLeft { get; set; }
    [Parameter] public double? MarginRight { get; set; }

    protected override void ProcessRecord() {
        var listItems = new List<ListItem>();
        PdfFont? resolvedFont = null;
        if (!string.IsNullOrEmpty(Font))
        {
            var fontsDict = SessionState.PSVariable.GetValue("Fonts") as IDictionary<string, PdfFont>;
            resolvedFont = ResolveFont(Font, fontsDict);
        }

        if (Items != null) {
            foreach (var item in Items) {
                var paragraph = PdfText.CreateParagraph(
                    new[] { item },
                    resolvedFont != null ? new[] { resolvedFont } : null,
                    FontColor.HasValue ? new[] { FontColor.Value } : null,
                    null,
                    FontSize,
                    TextAlignment,
                    (float?)MarginTop,
                    (float?)MarginBottom,
                    (float?)MarginLeft,
                    (float?)MarginRight);
                var listItem = new ListItem();
                listItem.Add(paragraph);
                listItems.Add(listItem);
            }
        } else if (ListItems != null) {
            foreach (var result in ListItems.Invoke()) {
                var value = (result as PSObject)?.BaseObject ?? result;
                switch (value) {
                    case ListItem item:
                        listItems.Add(item);
                        break;
                    case string text:
                        var paragraph = PdfText.CreateParagraph(
                            new[] { text },
                            resolvedFont != null ? new[] { resolvedFont } : null,
                            FontColor.HasValue ? new[] { FontColor.Value } : null,
                            null,
                            FontSize,
                            TextAlignment,
                            (float?)MarginTop,
                            (float?)MarginBottom,
                            (float?)MarginLeft,
                            (float?)MarginRight);
                        var listItem = new ListItem();
                        listItem.Add(paragraph);
                        listItems.Add(listItem);
                        break;
                }
            }
        }

        var document = SessionState.PSVariable.GetValue("Document") as Document;
        if (document == null) return;

        var list = new List();
        if (Indent.HasValue) {
            list.SetSymbolIndent((float)Indent.Value);
        }
        if (Symbol == ListSymbol.Bullet) {
            list.SetListSymbol("\u2022");
        }
        foreach (var item in listItems) {
            list.Add(item);
        }

        document.Add(list);
    }

    private static PdfFont? ResolveFont(string name, IDictionary<string, PdfFont>? customFonts)
    {
        if (string.IsNullOrEmpty(name))
            return null;

        if (Enum.TryParse(name, true, out PdfFontName enumFont))
        {
            return PdfHelpers.CreateFont(enumFont);
        }

        if (customFonts != null && customFonts.TryGetValue(name, out var pdfFont))
        {
            return pdfFont;
        }

        return null;
    }
}
