using System.Management.Automation;
using iText.Layout.Element;
using iText.Layout.Properties;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFArea")]
public class CmdletNewPDFArea : PSCmdlet
{
    [Parameter]
    public AreaBreakType AreaType { get; set; } = AreaBreakType.NEXT_AREA;

    [Parameter]
    public PdfPageSizeName? PageSize { get; set; }

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
