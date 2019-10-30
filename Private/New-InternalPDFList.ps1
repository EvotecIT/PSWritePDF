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
    foreach ($_ in $Settings.Items) {
        $null = $List.Add([iText.Layout.Element.ListItem]::new($_.Text))
    }
    $null = $Script:Document.Add($List)
}