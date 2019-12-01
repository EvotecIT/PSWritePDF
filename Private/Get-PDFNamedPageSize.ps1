function Get-PDFNamedPageSize {
    [CmdletBinding()]
    param(
        [int] $Height,
        [int] $Width
    )

    $PDFSizes = @{
        '33702384' = [PSCustomObject] @{ PageSize = 'A0'; Rotated = $false }
        '23843370' = [PSCustomObject] @{ PageSize = 'A0'; Rotated = $true }
        '23841684' = [PSCustomObject] @{ PageSize = 'A1'; Rotated = $false }
        '16842384' = [PSCustomObject] @{ PageSize = 'A1'; Rotated = $true }
        '10574'    = [PSCustomObject] @{ PageSize = 'A10'; Rotated = $false }
        '74105'    = [PSCustomObject] @{ PageSize = 'A10'; Rotated = $true }
        '16841190' = [PSCustomObject] @{ PageSize = 'A2'; Rotated = $false }
        '11901684' = [PSCustomObject] @{ PageSize = 'A2'; Rotated = $true }
        '1190842'  = [PSCustomObject] @{ PageSize = 'A3'; Rotated = $false }
        '8421190'  = [PSCustomObject] @{ PageSize = 'A3'; Rotated = $true }
        '842595'   = [PSCustomObject] @{ PageSize = 'A4'; Rotated = $false }
        '595842'   = [PSCustomObject] @{ PageSize = 'A4'; Rotated = $true }
        '595420'   = [PSCustomObject] @{ PageSize = 'A5'; Rotated = $false }
        '420595'   = [PSCustomObject] @{ PageSize = 'A5'; Rotated = $true }
        '420298'   = [PSCustomObject] @{ PageSize = 'A6'; Rotated = $false }
        '298420'   = [PSCustomObject] @{ PageSize = 'A6'; Rotated = $true }
        '298210'   = [PSCustomObject] @{ PageSize = 'A7'; Rotated = $false }
        '210298'   = [PSCustomObject] @{ PageSize = 'A7'; Rotated = $true }
        '210148'   = [PSCustomObject] @{ PageSize = 'A8'; Rotated = $false }
        '148210'   = [PSCustomObject] @{ PageSize = 'A8'; Rotated = $true }
        '547105'   = [PSCustomObject] @{ PageSize = 'A9'; Rotated = $false }
        '105547'   = [PSCustomObject] @{ PageSize = 'A9'; Rotated = $true }
        '40082834' = [PSCustomObject] @{ PageSize = 'B0'; Rotated = $false }
        '28344008' = [PSCustomObject] @{ PageSize = 'B0'; Rotated = $true }
        '28342004' = [PSCustomObject] @{ PageSize = 'B1'; Rotated = $false }
        '20042834' = [PSCustomObject] @{ PageSize = 'B1'; Rotated = $true }
        '12488'    = [PSCustomObject] @{ PageSize = 'B10'; Rotated = $false }
        '88124'    = [PSCustomObject] @{ PageSize = 'B10'; Rotated = $true }
        '20041417' = [PSCustomObject] @{ PageSize = 'B2'; Rotated = $false }
        '14172004' = [PSCustomObject] @{ PageSize = 'B2'; Rotated = $true }
        '14171000' = [PSCustomObject] @{ PageSize = 'B3'; Rotated = $false }
        '10001417' = [PSCustomObject] @{ PageSize = 'B3'; Rotated = $true }
        '1000708'  = [PSCustomObject] @{ PageSize = 'B4'; Rotated = $false }
        '7081000'  = [PSCustomObject] @{ PageSize = 'B4'; Rotated = $true }
        '708498'   = [PSCustomObject] @{ PageSize = 'B5'; Rotated = $false }
        '498708'   = [PSCustomObject] @{ PageSize = 'B5'; Rotated = $true }
        '498354'   = [PSCustomObject] @{ PageSize = 'B6'; Rotated = $false }
        '354498'   = [PSCustomObject] @{ PageSize = 'B6'; Rotated = $true }
        '354249'   = [PSCustomObject] @{ PageSize = 'B7'; Rotated = $false }
        '249354'   = [PSCustomObject] @{ PageSize = 'B7'; Rotated = $true }
        '249175'   = [PSCustomObject] @{ PageSize = 'B8'; Rotated = $false }
        '175249'   = [PSCustomObject] @{ PageSize = 'B8'; Rotated = $true }
        '175124'   = [PSCustomObject] @{ PageSize = 'B9'; Rotated = $false }
        '124175'   = [PSCustomObject] @{ PageSize = 'B9'; Rotated = $true }
        '756522'   = [PSCustomObject] @{ PageSize = 'EXECUTIVE'; Rotated = $false }
        '522756'   = [PSCustomObject] @{ PageSize = 'EXECUTIVE'; Rotated = $true }
        '7921224'  = [PSCustomObject] @{ PageSize = 'LEDGER or TABLOID'; Rotated = $false }
        '1224792'  = [PSCustomObject] @{ PageSize = 'LEDGER or TABLOID'; Rotated = $true }
        '1008612'  = [PSCustomObject] @{ PageSize = 'LEGAL'; Rotated = $false }
        '6121008'  = [PSCustomObject] @{ PageSize = 'LEGAL'; Rotated = $true }
        '792612'   = [PSCustomObject] @{ PageSize = 'LETTER'; Rotated = $false }
        '612792'   = [PSCustomObject] @{ PageSize = 'LETTER'; Rotated = $true }
    }
    $Size = $PDFSizes["$Height$Width"]
    if ($Size) {
        return $Size
    } else {
        return [PSCustomObject] @{ PageSize = 'Unknown'; $Rotated = $null }
    }
}