function New-InternalPDFText {
    param(
        #[iText.Layout.Document] $Document,
        [System.Collections.IDictionary] $Settings
    )
    $Paragraph = [iText.Layout.Element.Paragraph]::new()
    foreach ($_ in $Element.Settings.Text) {
        $null = $Paragraph.Add($_)
    }
    $null = $Script:Document.add($Paragraph)
}