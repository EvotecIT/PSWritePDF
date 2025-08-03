using iText.Layout;

namespace PdfIMO
{
    public static class PdfOptions
    {
        public static void Apply(
            Document document,
            float? marginLeft = null,
            float? marginRight = null,
            float? marginTop = null,
            float? marginBottom = null)
        {
            if (document == null)
            {
                return;
            }

            if (marginLeft.HasValue) document.SetLeftMargin(marginLeft.Value);
            if (marginRight.HasValue) document.SetRightMargin(marginRight.Value);
            if (marginTop.HasValue) document.SetTopMargin(marginTop.Value);
            if (marginBottom.HasValue) document.SetBottomMargin(marginBottom.Value);
        }
    }
}
