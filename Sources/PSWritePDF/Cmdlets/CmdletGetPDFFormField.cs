using System;
using System.Management.Automation;
using iText.Forms;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Retrieves form fields from a PDF document.</summary>
/// <para>Enumerates AcroForm fields and returns their names and objects.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>The cmdlet emits warnings if the document contains no forms.</description>
/// </item>
/// </list>
/// <example>
/// <summary>List form fields.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFFormField -PDF $pdf
/// </code>
/// <para>Outputs form field information.</para>
/// </example>
/// <example>
/// <summary>Stop on read errors.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Get-PDFFormField -PDF $pdf -ErrorAction Stop
/// </code>
/// <para>Throws a terminating error if forms cannot be read.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.Get, "PDFFormField")]
public class CmdletGetPDFFormField : PSCmdlet
{
    /// <summary>PDF document to inspect.</summary>
    [Parameter(Mandatory = true)]
    public PdfDocument PDF { get; set; } = null!;

    protected override void ProcessRecord()
    {
        try
        {
            var acroForm = PdfAcroForm.GetAcroForm(PDF, false);
            var fields = acroForm?.GetAllFormFields();
            if (fields != null)
            {
                foreach (var kv in fields)
                {
                    WriteObject(new PdfFormFieldInfo { Name = kv.Key, Field = kv.Value });
                }
            }
        }
        catch (Exception ex)
        {
            if (MyInvocation.BoundParameters.ContainsKey("ErrorAction") &&
                MyInvocation.BoundParameters["ErrorAction"].ToString() == "Stop")
            {
                ThrowTerminatingError(new ErrorRecord(ex, "GetPDFFormField", ErrorCategory.ReadError, PDF));
            }
            else
            {
                WriteWarning($"Get-PDFFormField - There was an error reading forms or no form exists. Exception: {ex.Message}");
            }
        }
    }
}
