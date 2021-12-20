function Convert-HTMLToPDF {
    <#
    .SYNOPSIS
    Converts HTML to PDF.

    .DESCRIPTION
    Converts HTML to PDF from one of three sources:
    1. A file on the local file system.
    2. A URL.
    3. A string of HTML.

    .PARAMETER Uri
    The URI of the HTML to convert.

    .PARAMETER Content
    The HTML (as a string) to convert.

    .PARAMETER FilePath
    The path to the file containing the HTML to convert.

    .PARAMETER OutputFilePath
    The path to the file to write the PDF to.

    .PARAMETER Open
    If true, opens the PDF after it is created.

    .EXAMPLE
    Convert-HTMLToPDF -Uri 'https://evotec.xyz/hub/scripts/pswritehtml-powershell-module/' -OutputFilePath "$PSScriptRoot\Example10-FromURL.pdf" -Open

    .EXAMPLE
    $HTMLInput = New-HTML {
        New-HTMLText -Text 'Test 1'
        New-HTMLTable -DataTable (Get-Process | Select-Object -First 3)
    }

    Convert-HTMLToPDF -Content $HTMLInput -OutputFilePath "$PSScriptRoot\Example10-FromHTML.pdf" -Open

    .EXAMPLE
    New-HTML {
        New-HTMLTable -DataTable (Get-Process | Select-Object -First 3)
    } -FilePath "$PSScriptRoot\Example10-FromFilePath.html" -Online

    Convert-HTMLToPDF -FilePath "$PSScriptRoot\Example10-FromFilePath.html" -OutputFilePath "$PSScriptRoot\Example10-FromFilePath.pdf" -Open

    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName = 'Uri')]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Uri')][alias('Url')][string] $Uri,
        [Parameter(Mandatory, ParameterSetName = 'Content')][string] $Content,
        [Parameter(Mandatory, ParameterSetName = 'FilePath')][string] $FilePath,
        [Parameter(Mandatory)][string] $OutputFilePath,
        [switch] $Open
    )
    # Load from file or text
    if ($FilePath) {
        if (Test-Path -LiteralPath $FilePath) {
            $Content = [IO.File]::ReadAllText($FilePath)
        } else {
            Write-Warning "Convert-HTMLToPDF - File $FilePath doesn't exists"
            return
        }
    } elseif ($Content) {

    } elseif ($Uri) {
        $ProgressPreference = 'SilentlyContinue'
        $Content = (Invoke-WebRequest -Uri $Uri).Content
    } else {
        Write-Warning 'Convert-HTMLToPDF - No choice file or content or url. Termninated.'
        return
    }
    if (-not $Content) {
        return
    }

    $OutputFile = [System.IO.FileInfo]::new($OutputFilePath)
    <#
    static void ConvertToPdf(string html, System.IO.Stream pdfStream)
    static void ConvertToPdf(string html, System.IO.Stream pdfStream, iText.Html2pdf.ConverterProperties converterProperties)
    static void ConvertToPdf(string html, iText.Kernel.Pdf.PdfWriter pdfWriter)
    static void ConvertToPdf(string html, iText.Kernel.Pdf.PdfWriter pdfWriter, iText.Html2pdf.ConverterProperties converterProperties)
    static void ConvertToPdf(string html, iText.Kernel.Pdf.PdfDocument pdfDocument, iText.Html2pdf.ConverterProperties converterProperties)
    static void ConvertToPdf(System.IO.FileInfo htmlFile, System.IO.FileInfo pdfFile)
    static void ConvertToPdf(System.IO.FileInfo htmlFile, System.IO.FileInfo pdfFile, iText.Html2pdf.ConverterProperties converterProperties)
    static void ConvertToPdf(System.IO.Stream htmlStream, System.IO.Stream pdfStream)
    static void ConvertToPdf(System.IO.Stream htmlStream, System.IO.Stream pdfStream, iText.Html2pdf.ConverterProperties converterProperties)
    static void ConvertToPdf(System.IO.Stream htmlStream, iText.Kernel.Pdf.PdfDocument pdfDocument)
    static void ConvertToPdf(System.IO.Stream htmlStream, iText.Kernel.Pdf.PdfWriter pdfWriter)
    static void ConvertToPdf(System.IO.Stream htmlStream, iText.Kernel.Pdf.PdfWriter pdfWriter, iText.Html2pdf.ConverterProperties converterProperties)
    static void ConvertToPdf(System.IO.Stream htmlStream, iText.Kernel.Pdf.PdfDocument pdfDocument, iText.Html2pdf.ConverterProperties converterProperties)
    #>
    try {
        [iText.Html2pdf.HtmlConverter]::ConvertToPdf($Content, $OutputFile)
    } catch {
        Write-Warning "Convert-HTMLToPDF - Error converting to PDF. Error: $($_.Exception.Message)"
        return
    }
    if ($Open) {
        Start-Process -FilePath $OutputFilePath -Wait
    }
}