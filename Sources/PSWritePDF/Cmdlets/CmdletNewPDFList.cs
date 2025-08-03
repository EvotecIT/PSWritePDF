using System.Collections.Generic;
using System.Management.Automation;
using iText.Layout;
using iText.Layout.Properties;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFList")]
public class CmdletNewPDFList : PSCmdlet {
    [Parameter(Position = 0)]
    public ScriptBlock? ListItems { get; set; }
    [Parameter] public double? Indent { get; set; }
    [Parameter] public ListSymbol Symbol { get; set; } = ListSymbol.Hyphen;
    [Parameter] public PdfFontName? Font { get; set; }
    [Parameter] public PdfColor? FontColor { get; set; }
    [Parameter] public int? FontSize { get; set; }
    [Parameter] public TextAlignment? TextAlignment { get; set; }
    [Parameter] public double? MarginTop { get; set; }
    [Parameter] public double? MarginBottom { get; set; }
    [Parameter] public double? MarginLeft { get; set; }
    [Parameter] public double? MarginRight { get; set; }

    protected override void ProcessRecord() {
        var items = new List<string>();
        if (ListItems != null) {
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
