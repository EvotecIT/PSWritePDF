namespace PSWritePDF;

/// <summary>Represents a PDF form field and its name.</summary>
public class PdfFormFieldInfo
{
    /// <summary>Name of the field.</summary>
    public string Name { get; set; } = string.Empty;

    /// <summary>The underlying form field object.</summary>
    public iText.Forms.Fields.PdfFormField Field { get; set; } = null!;
}
