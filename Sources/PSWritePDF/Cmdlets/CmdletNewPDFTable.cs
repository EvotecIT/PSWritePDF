using System;

using System.Management.Automation;
using iText.Layout;
using iText.Layout.Element;
using PdfIMO;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.New, "PDFTable")]
public class CmdletNewPDFTable : PSCmdlet {
    [Parameter]
    public PSObject[] DataTable { get; set; } = Array.Empty<PSObject>();

    protected override void ProcessRecord() {
        Table table = PdfTable.BuildTable(DataTable);
        var document = SessionState.PSVariable.GetValue("Document") as Document;
        document?.Add(table);
        WriteObject(table);
    }
}
