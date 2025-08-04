using System;
using System.Management.Automation;
using PSWritePDF;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Get, "PDFAction", DefaultParameterSetName = ParameterSetNames.ByName)]
[Alias("Get-PDFConstantAction")]
[OutputType(typeof(int), ParameterSetName = new[] { ParameterSetNames.ByName })]
[OutputType(typeof(PdfActionName), ParameterSetName = new[] { ParameterSetNames.All })]
public class CmdletGetPDFAction : PSCmdlet
{
    private static class ParameterSetNames
    {
        public const string ByName = "ByName";
        public const string All = "All";
    }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.ByName)]
    public PdfActionName Action { get; set; }

    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.All)]
    public SwitchParameter All { get; set; }

    protected override void ProcessRecord()
    {
        if (ParameterSetName == ParameterSetNames.All)
        {
            WriteObject(Enum.GetValues(typeof(PdfActionName)), true);
        }
        else
        {
            WriteObject(Action.ToInt());
        }
    }
}
