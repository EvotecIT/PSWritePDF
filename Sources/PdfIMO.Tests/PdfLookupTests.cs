using iText.IO.Font.Constants;
using iText.Kernel.Colors;
using iText.Layout.Properties;
using Xunit;

namespace PdfIMO.Tests;

public class PdfLookupTests
{
    [Fact]
    public void FontLookupReturnsStandardFont()
    {
        var font = PdfFontLookup.GetFont("HELVETICA");
        Assert.Equal(StandardFonts.HELVETICA, font);
        Assert.Contains("HELVETICA", PdfFontLookup.Names);
    }

    [Fact]
    public void ColorLookupReturnsColorConstant()
    {
        var color = PdfColorLookup.GetColor("BLUE");
        Assert.Equal(ColorConstants.BLUE, color);
        Assert.Contains("BLUE", PdfColorLookup.Names);
    }

    [Fact]
    public void LookupSupportsEnums()
    {
        var font = PdfFontLookup.GetFont(PdfFontName.HELVETICA);
        Assert.Equal(StandardFonts.HELVETICA, font);
        var color = PdfColorLookup.GetColor(PdfColor.Blue);
        Assert.Equal(ColorConstants.BLUE, color);
    }

    [Fact]
    public void TextAlignmentLookupReturnsEnum()
    {
        var alignment = PdfTextAlignmentLookup.GetAlignment("CENTER");
        Assert.Equal(TextAlignment.CENTER, alignment);
        Assert.Contains("CENTER", PdfTextAlignmentLookup.Names);
    }
}
