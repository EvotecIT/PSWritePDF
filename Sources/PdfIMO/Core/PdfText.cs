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
            IEnumerable<PdfFont> fonts = null,
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

            for (int i = 0; i < texts.Count; i++)
            {
                Text pdfText = new Text(texts[i]);

                if (fontList != null && fontList.Count > 0)
                {
                    var font = fontList.Count > i ? fontList[i] : fontList[0];
                    if (font != null)
                    {
                        pdfText.SetFont(font);
                    }
                }

                // FontBold is handled when resolving fonts in cmdlets

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
