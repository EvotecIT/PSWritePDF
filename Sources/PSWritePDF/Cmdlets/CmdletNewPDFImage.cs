using System.IO;
using System.Management.Automation;
using iText.Layout;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

/// <summary>Adds an image to the current PDF document.</summary>
/// <para>Loads an image from disk and inserts it with optional size and background color.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Image files must exist; missing files cause a terminating error.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Add an image.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFImage -ImagePath 'logo.png'
/// </code>
/// <para>Inserts the image using its original dimensions.</para>
/// </example>
/// <example>
/// <summary>Add image with size.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFImage -ImagePath 'logo.png' -Width 100 -Height 50
/// </code>
/// <para>Scales the image to the specified size.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFImage")]
public class CmdletNewPDFImage : PSCmdlet {
    /// <summary>Path to the image file.</summary>
    [Parameter(Mandatory = true)]
    [ValidateNotNullOrEmpty]
    public string ImagePath { get; set; } = string.Empty;
    /// <summary>Desired image width.</summary>
    [Parameter] public int Width { get; set; }
    /// <summary>Desired image height.</summary>
    [Parameter] public int Height { get; set; }
    /// <summary>Background color behind the image.</summary>
    [Parameter] public PdfColor? BackgroundColor { get; set; }
    /// <summary>Opacity of the background color.</summary>
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
