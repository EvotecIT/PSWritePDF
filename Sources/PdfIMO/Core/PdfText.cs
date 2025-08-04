using System.Collections.Generic;
using System.Linq;
using iText.Kernel.Colors;
using iText.Kernel.Font;
using iText.Layout.Element;
using iText.Layout.Properties;

namespace PdfIMO
{
    public static class PdfText
    {
        public static Paragraph CreateParagraph(
            IEnumerable<string> text,
            IEnumerable<PdfFontName> fonts = null,
            IEnumerable<PdfColor> fontColors = null,
            IEnumerable<bool?> fontBold = null,
            int? fontSize = null,
            TextAlignment? textAlignment = null,
            float? marginTop = null,
            float? marginBottom = null,
            float? marginLeft = null,
            float? marginRight = null)
        {
            var paragraph = new Paragraph();
            var texts = text?.ToList() ?? new List<string>();
            var fontList = fonts?.ToList();
            var colorList = fontColors?.ToList();
            var boldList = fontBold?.ToList();

            for (int i = 0; i < texts.Count; i++)
            {
                Text pdfText = new Text(texts[i]);

                if (fontList != null && fontList.Count > 0)
                {
                    var font = fontList.Count > i ? fontList[i] : fontList[0];
                    if (boldList != null && boldList.Count > 0)
                    {
                        var bold = boldList.Count > i ? boldList[i] : boldList[0];
                        if (bold.HasValue && bold.Value)
                        {
                            font = font switch
                            {
                                PdfFontName.COURIER => PdfFontName.COURIER_BOLD,
                                PdfFontName.COURIER_OBLIQUE => PdfFontName.COURIER_BOLDOBLIQUE,
                                PdfFontName.HELVETICA => PdfFontName.HELVETICA_BOLD,
                                PdfFontName.HELVETICA_OBLIQUE => PdfFontName.HELVETICA_BOLDOBLIQUE,
                                PdfFontName.TIMES_ROMAN => PdfFontName.TIMES_BOLD,
                                PdfFontName.TIMES_ITALIC => PdfFontName.TIMES_BOLDITALIC,
                                _ => font
                            };
                        }
                    }

                    PdfFont pdfFont = PdfHelpers.CreateFont(font);
                    pdfText.SetFont(pdfFont);
                }

                if (colorList != null && colorList.Count > 0)
                {
                    var color = colorList.Count > i ? colorList[i] : colorList[0];
                    Color converted = PdfHelpers.GetColor(color);
                    pdfText.SetFontColor(converted);
                }

                if (fontSize.HasValue)
                {
                    pdfText.SetFontSize(fontSize.Value);
                }

                paragraph.Add(pdfText);
            }

            if (textAlignment.HasValue)
            {
                paragraph.SetTextAlignment(textAlignment.Value);
            }
            if (marginTop.HasValue) paragraph.SetMarginTop(marginTop.Value);
            if (marginBottom.HasValue) paragraph.SetMarginBottom(marginBottom.Value);
            if (marginLeft.HasValue) paragraph.SetMarginLeft(marginLeft.Value);
            if (marginRight.HasValue) paragraph.SetMarginRight(marginRight.Value);
            return paragraph;
        }
    }
}
