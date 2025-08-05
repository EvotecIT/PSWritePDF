using System;
using System.Collections.Generic;
using System.Management.Automation;
using iText.Kernel.Font;
using iText.Layout.Element;
using iText.Layout.Properties;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFListItem")]
public class CmdletNewPDFListItem : PSCmdlet {
    [Parameter(Mandatory = true)]
    public string[] Text { get; set; } = Array.Empty<string>();

    [Parameter] public string[]? Font { get; set; }
    [Parameter] public PdfColor[]? FontColor { get; set; }
    [Parameter] public bool?[]? FontBold { get; set; }
    [Parameter] public int? FontSize { get; set; }
    [Parameter] public TextAlignment? TextAlignment { get; set; }
    [Parameter] public double? MarginTop { get; set; }
    [Parameter] public double? MarginBottom { get; set; }
    [Parameter] public double? MarginLeft { get; set; }
    [Parameter] public double? MarginRight { get; set; }

    protected override void ProcessRecord() {
        PdfFont[]? fonts = null;
        if (Font != null && Font.Length > 0)
        {
            var fontsDict = SessionState.PSVariable.GetValue("Fonts") as IDictionary<string, PdfFont>;
            fonts = new PdfFont[Font.Length];
            for (int i = 0; i < Font.Length; i++)
            {
                bool? bold = FontBold != null && FontBold.Length > i ? FontBold[i] : FontBold?.Length > 0 ? FontBold[0] : (bool?)null;
                fonts[i] = ResolveFont(Font[i], bold, fontsDict);
            }
        }

        var paragraph = PdfText.CreateParagraph(
            Text,
            fonts,
            FontColor,
            FontBold,
            FontSize,
            TextAlignment,
            (float?)MarginTop,
            (float?)MarginBottom,
            (float?)MarginLeft,
            (float?)MarginRight);

        var listItem = new ListItem();
        listItem.Add(paragraph);
        WriteObject(listItem);
    }

    private static PdfFont? ResolveFont(string name, bool? bold, IDictionary<string, PdfFont>? customFonts)
    {
        if (string.IsNullOrEmpty(name))
            return null;

        if (Enum.TryParse(name, true, out PdfFontName enumFont))
        {
            if (bold.HasValue && bold.Value)
            {
                enumFont = enumFont switch
                {
                    PdfFontName.COURIER => PdfFontName.COURIER_BOLD,
                    PdfFontName.COURIER_OBLIQUE => PdfFontName.COURIER_BOLDOBLIQUE,
                    PdfFontName.HELVETICA => PdfFontName.HELVETICA_BOLD,
                    PdfFontName.HELVETICA_OBLIQUE => PdfFontName.HELVETICA_BOLDOBLIQUE,
                    PdfFontName.TIMES_ROMAN => PdfFontName.TIMES_BOLD,
                    PdfFontName.TIMES_ITALIC => PdfFontName.TIMES_BOLDITALIC,
                    _ => enumFont
                };
            }
            return PdfHelpers.CreateFont(enumFont);
        }

        if (customFonts != null && customFonts.TryGetValue(name, out var pdfFont))
        {
            return pdfFont;
        }

        return null;
    }
}
