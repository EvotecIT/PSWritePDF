namespace PSWritePDF;

public class PdfFormFieldInfo
{
    public string Name { get; set; } = string.Empty;
    public iText.Forms.Fields.PdfFormField Field { get; set; } = null!;
}
