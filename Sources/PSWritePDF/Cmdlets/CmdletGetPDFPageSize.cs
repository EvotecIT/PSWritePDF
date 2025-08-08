using System;
using System.Management.Automation;
using PSWritePDF;

namespace PSWritePDF.Cmdlets;

/// <summary>Gets standard PDF page sizes.</summary>
/// <para>Returns an iText <c>PageSize</c> or enumerates available page size names.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Page size names correspond to <c>PdfPageSizeName</c> enumeration values.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Get size for A4.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFPageSize -PageSize A4
/// </code>
/// <para>Returns the iText page size for A4.</para>
/// </example>
/// <example>
/// <summary>List all page sizes.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFPageSize -All
/// </code>
/// <para>Displays all supported page size names.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
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

    /// <summary>Page size name to retrieve.</summary>
    [Parameter(Mandatory = true, ParameterSetName = ParameterSetNames.ByName)]
    public PdfPageSizeName PageSize { get; set; }

    /// <summary>Return all page size names.</summary>
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
