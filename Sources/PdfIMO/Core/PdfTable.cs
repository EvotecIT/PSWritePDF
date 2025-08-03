using System.Collections.Generic;
using System.Linq;
using iText.Layout.Element;

namespace PdfIMO
{
    public static class PdfTable
    {
        public static Table BuildTable<T>(IEnumerable<T> data)
        {
            var list = data.ToList();
            if (!list.Any())
            {
                return new Table(1);
            }

            var properties = typeof(T).GetProperties();
            var table = new Table(properties.Length).UseAllAvailableWidth();

            foreach (var prop in properties)
            {
                var headerParagraph = PdfText.CreateParagraph(new[] { prop.Name });
                table.AddHeaderCell(new Cell().Add(headerParagraph));
            }

            foreach (var item in list)
            {
                foreach (var prop in properties)
                {
                    var value = prop.GetValue(item)?.ToString() ?? string.Empty;
                    var paragraph = PdfText.CreateParagraph(new[] { value });
                    table.AddCell(new Cell().Add(paragraph));
                }
            }

            return table;
        }
    }
}
