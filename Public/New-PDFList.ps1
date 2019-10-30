function New-PDFList {
    param(
        [ScriptBlock] $ListItems,
        [nullable[float]] $Indent,
        [string] $Symbol
    )

    $Output = & $ListItems
    $Items = foreach ($_ in $Output) {
        if ($_.Type -eq 'ListItem') {
            $_.Settings
        }
    }

    [PSCustomObject] @{
        Type     = 'List'
        Settings = @{
            Items = $Items
            Indent = $Indent
            Symbol = $Symbol
        }
    }
}