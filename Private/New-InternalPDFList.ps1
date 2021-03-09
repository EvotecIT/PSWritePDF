function New-InternalPDFList {
    [CmdletBinding()]
    param(
        [System.Collections.IDictionary] $Settings
    )

    $List = [iText.Layout.Element.List]::new()
    if ($null -ne $Settings.Indent) {
        $null = $List.SetSymbolIndent($Settings.Indent)
    }
    if ($Settings.Symbol) {
        if ($Settings.Symbol -eq 'hyphen') {
            # Default
        } elseif ($Settings.Symbol -eq 'bullet') {
            $Symbol = [regex]::Unescape("\u2022")
            $null = $List.SetListSymbol($Symbol)
        }

    }
    foreach ($ItemSettings in $Settings.Items) {
        $Paragraph = New-InternalPDFText @ItemSettings
        $ListItem = [iText.Layout.Element.ListItem]::new()
        $null = $ListItem.Add($Paragraph)
        $null = $List.Add($ListItem)
    }
    $null = $Script:Document.Add($List)
}