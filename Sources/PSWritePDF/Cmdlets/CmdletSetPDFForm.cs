using System;
using System.Collections;
using System.IO;
using System.Management.Automation;
using iText.Forms;
using iText.Forms.Fields;
using iText.Kernel.Pdf;

namespace PSWritePDF.Cmdlets;

[Cmdlet(VerbsCommon.Set, "PDFForm")]
[Alias("Set-PDFForm")]
public class CmdletSetPDFForm : PSCmdlet
{
    [Parameter(Mandatory = true)]
    [ValidateNotNullOrEmpty]
    public string SourceFilePath { get; set; }

    [Parameter(Mandatory = true)]
    [ValidateNotNullOrEmpty]
    public string DestinationFilePath { get; set; }

    [Parameter]
    public IDictionary FieldNameAndValueHashTable { get; set; }

    [Parameter]
    [Alias("FlattenFields")]
    public SwitchParameter Flatten { get; set; }

    [Parameter]
    public SwitchParameter IgnoreProtection { get; set; }

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
        }
        catch (Exception ex)
        {
            WriteWarning($"Error has occurred: {ex.Message}");
        }
    }
}

