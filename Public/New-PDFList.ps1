function New-PDFList {
    [CmdletBinding()]
    param(
        [ScriptBlock] $ListItems,
        [nullable[float]] $Indent,
        [ValidateSet('bullet', 'hyphen')][string] $Symbol = 'hyphen'
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
            Items  = $Items
            Indent = $Indent
            Symbol = $Symbol
        }
    }
}