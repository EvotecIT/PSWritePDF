using System.Management.Automation;
using iText.Layout.Element;
using iText.Layout.Properties;

namespace PSWritePDF.Cmdlets;

/// <summary>Creates a new area break for PDF content.</summary>
/// <para>Generates an iText <c>AreaBreak</c> object used to separate sections in a PDF document.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The returned area break must be added to a PDF document to take effect.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Create a default area break.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFArea
/// </code>
/// <para>Creates a break with default settings.</para>
/// </example>
/// <example>
/// <summary>Create a rotated A4 area break.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFArea -PageSize A4 -Rotate
/// </code>
/// <para>Produces a break on a landscape A4 page.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFArea")]
public class CmdletNewPDFArea : PSCmdlet
{
    /// <summary>Type of area break to insert.</summary>
    [Parameter]
    public AreaBreakType AreaType { get; set; } = AreaBreakType.NEXT_AREA;

    /// <summary>Page size for the new area.</summary>
    [Parameter]
    public PdfPageSizeName? PageSize { get; set; }

    /// <summary>Rotate the page to landscape.</summary>
    [Parameter]
    public SwitchParameter Rotate { get; set; }

    protected override void ProcessRecord()
    {
        var areaBreak = new AreaBreak(AreaType);
        var page = PageSize.HasValue ? PageSize.Value.ToPageSize() : iText.Kernel.Geom.PageSize.A4;
        if (Rotate.IsPresent)
        {
            page = page.Rotate();
        }
        areaBreak.SetPageSize(page);
        WriteObject(areaBreak);
    }
}
