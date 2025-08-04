using System;
using System.Management.Automation;
using iText.Forms;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Get, "PDFFormField")]
public class CmdletGetPDFFormField : PSCmdlet
{
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
