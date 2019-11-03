function New-InternalPDFText {
    [CmdletBinding()]
    param(
        [System.Collections.IDictionary] $Settings
    )
    foreach ($_ in $Settings) {
        $Paragraph = [iText.Layout.Element.Paragraph]::new()

        if ($_.FontBold) {
            [Array] $FontBold = $_.FontBold
            $DefaultBold = $FontBold[0]
        }
        if ($_.FontColor) {
            [Array] $FontColor = $_.FontColor
            $DefaultColor = $FontColor[0]
        }
        if ($_.Font) {
            [Array] $Font = $_.Font
            $DefaultFont = $Font[0]
        }

        for ($i = 0; $i -lt $_.Text.Count; $i++) {
            [iText.Layout.Element.Text] $Text = $_.Text[$i]

            if ($FontBold) {
                if ($null -ne $FontBold[$i]) {
                    if ($FontBold[$i]) {
                        $Text = $Text.SetBold()
                    }
                } else {
                    if ($DefaultBold) {
                        $Text = $Text.SetBold()
                    }
                }
            }
            if ($FontColor) {
                if ($null -ne $FontColor[$i]) {
                    if ($FontColor[$i]) {
                        $ConvertedColor = Get-PDFConstantColor -Color $FontColor[$i]
                        $Text = $Text.SetFontColor($ConvertedColor)
                    }
                } else {
                    if ($DefaultColor) {
                        $ConvertedColor = Get-PDFConstantColor -Color $DefaultColor
                        $Text = $Text.SetFontColor($ConvertedColor)
                    }
                }
            }
            if ($Font) {
                if ($null -ne $Font[$i]) {
                    if ($Font[$i]) {
                        $ConvertedFont = Get-PDFConstantFont -Font $Font[$i]
                        $ApplyFont = [iText.Kernel.Font.PdfFontFactory]::CreateFont($ConvertedFont)
                        $Text = $Text.SetFont($ApplyFont)
                    }
                } else {
                    if ($DefaultColor) {
                        $ConvertedFont = Get-PDFConstantFont -Font $DefaultFont
                        $ApplyFont = [iText.Kernel.Font.PdfFontFactory]::CreateFont($ConvertedFont)
                        $Text = $Text.SetFont($ApplyFont)
                    }
                }
            }
            $null = $Paragraph.Add($Text)
        }
        $Paragraph
    }
}