using System;
using System.Management.Automation;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFText")]
public class CmdletNewPDFText : PSCmdlet {
    [Parameter(Mandatory = true)]
    public string[] Text { get; set; } = Array.Empty<string>();

    [Parameter] public PdfFontName[]? Font { get; set; }
    [Parameter] public PdfColor[]? FontColor { get; set; }
    [Parameter] public bool?[]? FontBold { get; set; }
    [Parameter] public int? FontSize { get; set; }
    [Parameter] public TextAlignment? TextAlignment { get; set; }
    [Parameter] public double? MarginTop { get; set; } = 2;
    [Parameter] public double? MarginBottom { get; set; } = 2;
    [Parameter] public double? MarginLeft { get; set; }
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
