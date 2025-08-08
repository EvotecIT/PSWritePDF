using System;

using System.Management.Automation;
using iText.Layout;
using iText.Layout.Element;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

/// <summary>Creates a table in the current PDF document.</summary>
/// <para>Builds an iText <c>Table</c> from PowerShell objects and adds it to the active document.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The table is added only when a document is stored in the session.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Add a table from objects.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFTable -DataTable $objects
/// </code>
/// <para>Creates a table using property names as columns.</para>
/// </example>
/// <example>
/// <summary>Create an empty table.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>New-PDFTable
/// </code>
/// <para>Outputs a table object without adding rows.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.New, "PDFTable")]
public class CmdletNewPDFTable : PSCmdlet {
    /// <summary>Objects representing table rows.</summary>
    [Parameter]
    public PSObject[] DataTable { get; set; } = Array.Empty<PSObject>();

    protected override void ProcessRecord() {
        Table table = PdfTable.BuildTable(DataTable);
        var document = SessionState.PSVariable.GetValue("Document") as Document;
        document?.Add(table);
        WriteObject(table);
    }
}
