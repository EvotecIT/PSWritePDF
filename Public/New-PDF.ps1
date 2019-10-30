function New-PDF {
    [CmdletBinding()]
    param(
        [scriptblock] $PDFContent,
        [string] $FilePath,
        [alias('Open')][switch] $Show
    )
    $Script:Document = New-InternalPDF -FilePath $FilePath

    [Array] $Output = & $PDFContent
    foreach ($Element in $Output) {
        if ($Element.Type -eq 'Text') {
            New-InternalPDFText -Settings $Element.Settings
        }
        if ($Element.Type -eq 'List') {
            New-InternalPDFList -Settings $Element.Settings
        }
        if ($Element.Type -eq 'Paragraph') {

        }
    }

    $Script:PDF.Close();

    if ($Show) {
        if (Test-Path -LiteralPath $FilePath) {
            Invoke-Item -LiteralPath $FilePath
        }
    }
}