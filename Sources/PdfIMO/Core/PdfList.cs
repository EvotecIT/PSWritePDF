using System.Collections.Generic;
using iText.Layout;
using iText.Layout.Element;

namespace PdfIMO
{
    public static class PdfList
    {
        public static void AddList(
            Document document,
            IEnumerable<string> items,
            float? indent = null,
            ListSymbol symbol = ListSymbol.Hyphen,
            PdfFontName? font = null,
            PdfColor? fontColor = null,
            int? fontSize = null,
            iText.Layout.Properties.TextAlignment? textAlignment = null,
            float? marginTop = null,
            float? marginBottom = null,
            float? marginLeft = null,
            float? marginRight = null)
        {
            var list = new List();
            if (indent.HasValue)
            {
                list.SetSymbolIndent(indent.Value);
            }
            if (symbol == ListSymbol.Bullet)
            {
                list.SetListSymbol("\u2022");
            }

            foreach (var item in items)
            {
                var paragraph = PdfText.CreateParagraph(
                    new[] { item },
                    font.HasValue ? new[] { font.Value } : null,
                    fontColor.HasValue ? new[] { fontColor.Value } : null,
                    fontSize,
                    textAlignment,
                    marginTop,
                    marginBottom,
                    marginLeft,
                    marginRight);
                var listItem = new ListItem();
                listItem.Add(paragraph);
                list.Add(listItem);
            }

            document.Add(list);
        }
    }
}
