function New-InternalPDFList {
    [CmdletBinding()]
    param(
        [System.Collections.IDictionary] $Settings
    )

    $List = [iText.Layout.Element.List]::new()
    if ($null -ne $Settings.Indent) {
        $List.SetSymbolIndent($Settings.Indent)
    }
    if ($Settings.Symbol) {
        $List.SetListSymbol($Settings.Symbol)
        #$List.SetListSymbol
    }
    foreach ($_ in $Settings.Items) {
        $List.Add([iText.Layout.Element.ListItem]::new($_.Text))
    }
    $Script:Document.Add($List)
}