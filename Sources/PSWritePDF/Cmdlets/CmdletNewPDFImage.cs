using System.IO;
using System.Management.Automation;
using iText.Layout;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFImage")]
public class CmdletNewPDFImage : PSCmdlet {
    [Parameter(Mandatory = true)]
    public string ImagePath { get; set; } = string.Empty;
    [Parameter] public int Width { get; set; }
    [Parameter] public int Height { get; set; }
    [Parameter] public PdfColor? BackgroundColor { get; set; }
    [Parameter] public double? BackgroundColorOpacity { get; set; }

    protected override void ProcessRecord() {
        if (!File.Exists(ImagePath)) {
            var message = $"Image file '{ImagePath}' was not found.";
            var exception = new FileNotFoundException(message, ImagePath);
            var errorRecord = new ErrorRecord(exception, "ImageNotFound", ErrorCategory.ObjectNotFound, ImagePath);
            ThrowTerminatingError(errorRecord);
            return;
        }

        var document = SessionState.PSVariable.GetValue("Document") as Document;
        if (document != null) {
            var image = PdfImage.AddImage(document, ImagePath, Width, Height, BackgroundColor, BackgroundColorOpacity);
            WriteObject(image);
        }
    }
}
