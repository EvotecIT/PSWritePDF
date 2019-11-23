function New-InternalPDFText {
    [CmdletBinding()]
    param(
        [string[]] $Text,
        [ValidateScript( { & $Script:PDFFontValidation } )][string[]] $Font,
        #[string[]] $FontFamily,
        [ValidateScript( { & $Script:PDFColorValidation } )][string[]] $FontColor,
        [bool[]] $FontBold
    )

    $Paragraph = [iText.Layout.Element.Paragraph]::new()

    if ($FontBold) {
        [Array] $FontBold = $FontBold
        $DefaultBold = $FontBold[0]
    }
    if ($FontColor) {
        [Array] $FontColor = $FontColor
        $DefaultColor = $FontColor[0]
    }
    if ($Font) {
        [Array] $Font = $Font
        $DefaultFont = $Font[0]
    }

    for ($i = 0; $i -lt $Text.Count; $i++) {
        [iText.Layout.Element.Text] $PDFText = $Text[$i]

        if ($FontBold) {
            if ($null -ne $FontBold[$i]) {
                if ($FontBold[$i]) {
                    $PDFText = $PDFText.SetBold()
                }
            } else {
                if ($DefaultBold) {
                    $PDFText = $PDFText.SetBold()
                }
            }
        }
        if ($FontColor) {
            if ($null -ne $FontColor[$i]) {
                if ($FontColor[$i]) {
                    $ConvertedColor = Get-PDFConstantColor -Color $FontColor[$i]
                    $PDFText = $PDFText.SetFontColor($ConvertedColor)
                }
            } else {
                if ($DefaultColor) {
                    $ConvertedColor = Get-PDFConstantColor -Color $DefaultColor
                    $PDFText = $PDFText.SetFontColor($ConvertedColor)
                }
            }
        }
        if ($Font) {
            if ($null -ne $Font[$i]) {
                if ($Font[$i]) {
                    $ConvertedFont = Get-PDFConstantFont -Font $Font[$i]
                    $ApplyFont = [iText.Kernel.Font.PdfFontFactory]::CreateFont($ConvertedFont)
                    $PDFText = $PDFText.SetFont($ApplyFont)
                }
            } else {
                if ($DefaultColor) {
                    $ConvertedFont = Get-PDFConstantFont -Font $DefaultFont
                    $ApplyFont = [iText.Kernel.Font.PdfFontFactory]::CreateFont($ConvertedFont)
                    $PDFText = $PDFText.SetFont($ApplyFont)
                }
            }
        }
        $null = $Paragraph.Add($PDFText)
    }
    $Paragraph
}