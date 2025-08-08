using System;
using System.Collections;
using System.IO;
using System.Management.Automation;
using iText.Forms;
using iText.Forms.Fields;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

/// <summary>Sets values of PDF form fields.</summary>
/// <para>Copies an existing PDF, populates AcroForm fields, and optionally flattens them.</para>
/// <list type="alertSet">
/// <item>
/// <term>Note</term>
/// <description>Source documents are read entirely and may require removal of protection for editing.</description>
/// </item>
/// </list>
/// <example>
/// <summary>Populate form fields.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Set-PDFForm -SourceFilePath 'in.pdf' -DestinationFilePath 'out.pdf' -FieldNameAndValueHashTable $hash
/// </code>
/// <para>Copies the source PDF and sets fields as specified.</para>
/// </example>
/// <example>
/// <summary>Flatten fields.</summary>
/// <code>
/// <prefix>PS&gt; </prefix>Set-PDFForm -SourceFilePath 'in.pdf' -DestinationFilePath 'out.pdf' -Flatten
/// </code>
/// <para>Writes a new PDF with non-editable fields.</para>
/// </example>
/// <seealso href="https://learn.microsoft.com/dotnet/api/system.management.automation.cmdlet">MS Learn</seealso>
/// <seealso href="https://evotec.xyz/hub/scripts/pswritepdf/">Project documentation</seealso>
[Cmdlet(VerbsCommon.Set, "PDFForm")]
public class CmdletSetPDFForm : PSCmdlet
{
    /// <summary>Path to the source PDF with form fields.</summary>
    [Parameter(Mandatory = true)]
    [ValidateNotNullOrEmpty]
    public string SourceFilePath { get; set; }

    /// <summary>Destination path for the output PDF.</summary>
    [Parameter(Mandatory = true)]
    [ValidateNotNullOrEmpty]
    public string DestinationFilePath { get; set; }

    /// <summary>Hashtable of field names and values.</summary>
    [Parameter(ValueFromPipeline = true)]
    public IDictionary FieldNameAndValueHashTable { get; set; }

    /// <summary>Flatten the fields to make them read-only.</summary>
    [Parameter]
    [Alias("FlattenFields")]
    public SwitchParameter Flatten { get; set; }

    /// <summary>Ignore document protection when reading.</summary>
    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

    /// <summary>Return the destination file path.</summary>
    [Parameter]
    public SwitchParameter PassThru { get; set; }

    protected override void ProcessRecord()
    {
        if (!File.Exists(SourceFilePath))
        {
            WriteWarning($"Path '{SourceFilePath}' doesn't exist. Terminating.");
            return;
        }

        var destinationFolder = Path.GetDirectoryName(DestinationFilePath);
        if (string.IsNullOrEmpty(destinationFolder) || !Directory.Exists(destinationFolder))
        {
            WriteWarning($"Folder '{destinationFolder}' doesn't exist. Terminating.");
            return;
        }

        try
        {
            using var reader = new PdfReader(SourceFilePath);
            if (IgnoreProtection)
            {
                reader.SetUnethicalReading(true);
            }

            using var writer = new PdfWriter(DestinationFilePath);
            using var pdf = new PdfDocument(reader, writer);
            var form = PdfAcroForm.GetAcroForm(pdf, true);

            if (FieldNameAndValueHashTable != null)
            {
                foreach (DictionaryEntry kvp in FieldNameAndValueHashTable)
                {
                    var key = kvp.Key?.ToString();
                    var value = kvp.Value;

                    if (key == null)
                    {
                        continue;
                    }

                    var field = form.GetField(key);
                    if (field == null)
                    {
                        WriteWarning($"No form field with name '{key}' found");
                        continue;
                    }

                    try
                    {
                        if (field is PdfButtonFormField buttonField && value is bool b)
                        {
                            var states = buttonField.GetAppearanceStates();
                            var index = b ? 1 : 0;
                            if (index < states.Length)
                            {
                                buttonField.SetValue(states[index]);
                            }
                        }
                        else
                        {
                            field.SetValue(value?.ToString() ?? string.Empty);
                        }
                    }
                    catch (Exception ex)
                    {
                        WriteWarning($"Setting field '{key}' failed: {ex.Message}");
                    }
                }
            }

            if (Flatten)
            {
                form.FlattenFields();
            }

            if (PassThru)
            {
                WriteObject(DestinationFilePath);
            }
        }
        catch (Exception ex)
        {
            WriteWarning($"Error has occurred: {ex.Message}");
        }
    }
}

