using System;
using System.Management.Automation;
using PSWritePDF;

namespace PSWritePDF.Cmdlets;

/// <summary>Gets numeric values of PDF actions.</summary>
/// <para>Converts <c>PdfActionName</c> values to their integer representation or lists all names.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Action names correspond to constants defined in iText.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Get integer value for an action.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFAction -Action Hide
/// </code>
/// <para>Returns the numeric constant for the Hide action.</para>
/// </example>
/// <example>
/// <summary>List all action names.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFAction -All
/// </code>
/// <para>Displays all available action names.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
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

    /// <summary>Action name to translate.</summary>
    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.ByName)]
    public PdfActionName Action { get; set; }

    /// <summary>Return all action names.</summary>
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
