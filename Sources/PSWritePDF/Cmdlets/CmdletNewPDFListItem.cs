using System.Management.Automation;

namespace PSWritePDF.Cmdlets;

/// <summary>Creates a list item string.</summary>
/// <para>Outputs the provided text for use with <c>New-PDFList</c>.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>This cmdlet simply echoes the text as a list item.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Create an item.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFListItem -Text 'First'
/// </code>
/// <para>Returns the string 'First'.</para>
/// </example>
/// <example>
/// <summary>Use with a list.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFList -ListItems { New-PDFListItem -Text 'A' }
/// </code>
/// <para>Creates a list containing one item.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFListItem")]
public class CmdletNewPDFListItem : PSCmdlet {
    /// <summary>Text for the list item.</summary>
    [Parameter(Mandatory = true)]
    public string Text { get; set; } = string.Empty;

    protected override void ProcessRecord() {
        WriteObject(Text);
    }
}
