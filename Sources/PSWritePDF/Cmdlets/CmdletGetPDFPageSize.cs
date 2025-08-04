using System;
using System.Management.Automation;
using PSWritePDF;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Get, "PDFPageSize", DefaultParameterSetName = ParameterSetNames.ByName)]
[Alias("Get-PDFConstantPageSize")]
[OutputType(typeof(iText.Kernel.Geom.PageSize), ParameterSetName = new[] { ParameterSetNames.ByName })]
[OutputType(typeof(PdfPageSizeName), ParameterSetName = new[] { ParameterSetNames.All })]
public class CmdletGetPDFPageSize : PSCmdlet
{
    private static class ParameterSetNames
    {
        public const string ByName = "ByName";
        public const string All = "All";
    }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.ByName)]
    public PdfPageSizeName PageSize { get; set; }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.All)]
    public SwitchParameter All { get; set; }

    protected override void ProcessRecord()
    {
        if (ParameterSetName == ParameterSetNames.All)
        {
            WriteObject(Enum.GetValues(typeof(PdfPageSizeName)), true);
        }
        else
        {
            WriteObject(PageSize.ToPageSize());
        }
    }
}
