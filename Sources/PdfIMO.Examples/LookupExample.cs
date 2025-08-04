using System;

namespace PdfIMO.Examples;

public static class LookupExample
{
    public static void ShowLookups()
    {
        Console.WriteLine("Available fonts: " + string.Join(", ", PdfFontLookup.Names));
        Console.WriteLine("Available colors: " + string.Join(", ", PdfColorLookup.Names));
        Console.WriteLine("Available alignments: " + string.Join(", ", PdfTextAlignmentLookup.Names));
    }
}

