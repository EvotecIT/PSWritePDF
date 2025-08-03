using iText.IO.Image;
using iText.Layout;
using iText.Layout.Element;

namespace PdfIMO
{
    public static class PdfImage
    {
        public static void AddImage(
            Document document,
            string imagePath,
            int? width = null,
            int? height = null,
            PdfColor? backgroundColor = null,
            double? backgroundColorOpacity = null)
        {
            var imageData = ImageDataFactory.Create(imagePath);
            var image = new Image(imageData);

            if (width.HasValue) image.SetWidth(width.Value);
            if (height.HasValue) image.SetHeight(height.Value);

            if (backgroundColor.HasValue)
            {
                var rgb = PdfHelpers.GetColor(backgroundColor.Value);
                image.SetBackgroundColor(rgb);
                if (backgroundColorOpacity.HasValue)
                {
                    image.SetOpacity((float)backgroundColorOpacity.Value);
                }
            }

            document.Add(image);
        }
    }
}
