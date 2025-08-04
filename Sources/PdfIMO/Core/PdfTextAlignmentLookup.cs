using System;
using System.Collections.Generic;
using System.Linq;
using iText.Layout.Properties;

namespace PdfIMO;

public static class PdfTextAlignmentLookup
{
    private static readonly IReadOnlyDictionary<string, TextAlignment> Alignments =
        Enum.GetValues(typeof(TextAlignment))
            .Cast<TextAlignment>()
            .ToDictionary(a => a.ToString(), a => a, StringComparer.OrdinalIgnoreCase);

    public static TextAlignment GetAlignment(string name)
    {
        if (!Alignments.TryGetValue(name, out var alignment))
            throw new ArgumentException($"Text alignment '{name}' was not found.", nameof(name));
        return alignment;
    }

    public static IReadOnlyCollection<string> Names => Alignments.Keys.ToArray();
}

