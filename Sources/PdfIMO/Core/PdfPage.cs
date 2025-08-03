using iText.Kernel.Geom;
using iText.Kernel.Pdf;
using iText.Layout;

namespace PdfIMO
{
    public static class PdfPage
    {
        public static Document AddPage(
            PdfDocument pdf,
            PdfPageSize pageSize = PdfPageSize.Default,
            bool rotate = false,
            float? marginLeft = null,
            float? marginRight = null,
            float? marginTop = null,
            float? marginBottom = null)
        {
            PageSize size = PdfHelpers.GetPageSize(pageSize);
            if (rotate)
            {
                size = size.Rotate();
            }

            pdf.AddNewPage(size);
            var document = new Document(pdf);

            if (marginLeft.HasValue) document.SetLeftMargin(marginLeft.Value);
            if (marginRight.HasValue) document.SetRightMargin(marginRight.Value);
            if (marginTop.HasValue) document.SetTopMargin(marginTop.Value);
            if (marginBottom.HasValue) document.SetBottomMargin(marginBottom.Value);

            return document;
        }
    }
}
