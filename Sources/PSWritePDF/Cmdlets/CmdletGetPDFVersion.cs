using System;
using System.Management.Automation;
using PSWritePDF;

namespace PSWritePDF.Cmdlets;

/// <summary>Retrieves PDF version information.</summary>
/// <para>Returns a specific PDF version constant or lists all available versions.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Version names must match those defined by iText.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Get a specific version.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFVersion -Version PDF_2_0
/// </code>
/// <para>Returns the iText version constant for PDF 2.0.</para>
/// </example>
/// <example>
/// <summary>List all versions.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFVersion -All
/// </code>
/// <para>Displays all supported PDF versions.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
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

    /// <summary>Version name to translate.</summary>
    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.ByName)]
    public PdfVersionName Version { get; set; }

    /// <summary>Return all version names.</summary>
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
