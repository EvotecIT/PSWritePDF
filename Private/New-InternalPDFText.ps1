function New-InternalPDFText {
    [CmdletBinding()]
    param(
        #[iText.Layout.Document] $Document,
        [System.Collections.IDictionary] $Settings
    )
    #
    #[iText.IO.Font.Constants.StandardFonts]::HELVETICA
    $Paragraph = [iText.Layout.Element.Paragraph]::new()
    foreach ($_ in $Settings) {
        if ($_.Font) {
            $Font = [iText.IO.Font.Constants.StandardFonts]::($_.Font)
            $ApplyFont = [iText.Kernel.Font.PdfFontFactory]::CreateFont($Font)
            $null = $Paragraph.Add($_.Text).SetFont($ApplyFont)
        } else {
            $null = $Paragraph.Add($_.Text)
        }
    }
    $null = $Script:Document.add($Paragraph)
}