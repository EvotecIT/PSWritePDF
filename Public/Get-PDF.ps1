function Get-PDF {
    <#
    .SYNOPSIS
    Gets PDF file and returns it as an PDF object

    .DESCRIPTION
    Gets PDF file and returns it as an PDF object

    .PARAMETER FilePath
    Path to the PDF file to be processed

    .PARAMETER IgnoreProtection
    The switch will allow reading of PDF files that are "owner password" encrypted for protection/security (e.g. preventing copying of text, printing etc).
    The switch doesn't allow reading of PDF files that are "user password" encrypted (i.e. you cannot open them without the password)

    .EXAMPLE
    $Document = Get-PDF -FilePath "C:\Users\przemyslaw.klys\OneDrive - Evotec\Support\GitHub\PSWritePDF\Example\Example01.HelloWorld\Example01_WithSectionsMix.pdf"
    $Details = Get-PDFDetails -Document $Document
    $Details | Format-List
    $Details.Pages | Format-Table

    Close-PDF -Document $Document

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        [string] $FilePath,
        [switch] $IgnoreProtection
    )

    if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
        $ResolvedPath = Convert-Path -LiteralPath $FilePath

        try {
            $PDFFile = [iText.Kernel.Pdf.PdfReader]::new($ResolvedPath)
            if ($IgnoreProtection) {
                $null = $PDFFile.SetUnethicalReading($true)
            }
            $Document = [iText.Kernel.Pdf.PdfDocument]::new($PDFFile)
        } catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "Get-PDF - Processing document $FilePath failed with error: $ErrorMessage"
        }
        $Document

    }
}