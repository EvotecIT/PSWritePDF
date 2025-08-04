using System;
using System.Management.Automation;
using PSWritePDF;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Get, "PDFVersion", DefaultParameterSetName = ParameterSetNames.ByName)]
[Alias("Get-PDFConstantVersion")]
[OutputType(typeof(iText.Kernel.Pdf.PdfVersion), ParameterSetName = new[] { ParameterSetNames.ByName })]
[OutputType(typeof(PdfVersionName), ParameterSetName = new[] { ParameterSetNames.All })]
public class CmdletGetPDFVersion : PSCmdlet
{
    private static class ParameterSetNames
    {
        public const string ByName = "ByName";
        public const string All = "All";
    }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.ByName)]
    public PdfVersionName Version { get; set; }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.All)]
    public SwitchParameter All { get; set; }

    protected override void ProcessRecord()
    {
        if (ParameterSetName == ParameterSetNames.All)
        {
            WriteObject(Enum.GetValues(typeof(PdfVersionName)), true);
        }
        else
        {
            WriteObject(Version.ToPdfVersion());
        }
    }
}
