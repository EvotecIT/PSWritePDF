using System;
using System.Collections.Generic;
using System.Linq;
using iText.Kernel.Colors;

namespace PdfIMO;

public static class PdfColorLookup
{
    private static readonly Dictionary<PdfColor, Color> Colors = new()
    {
        { PdfColor.Black, ColorConstants.BLACK },
        { PdfColor.Blue, ColorConstants.BLUE },
        { PdfColor.Red, ColorConstants.RED },
        { PdfColor.Green, ColorConstants.GREEN },
        { PdfColor.Gray, ColorConstants.GRAY },
        { PdfColor.Yellow, ColorConstants.YELLOW }
    };

    private static readonly string[] ColorNames = Enum.GetNames(typeof(PdfColor));

    public static Color GetColor(PdfColor color) => Colors[color];

    public static Color GetColor(string name)
    {
        if (!Enum.TryParse(name, true, out PdfColor colorEnum))
            throw new ArgumentException($"Color '{name}' was not found in ColorConstants.", nameof(name));
        return GetColor(colorEnum);
    }

    public static IReadOnlyCollection<string> Names => ColorNames.Select(n => n.ToUpperInvariant()).ToArray();
}

