function New-PDFTable {
    [CmdletBinding()]
    param(
        [Array] $DataTable
    )
    if ($null -ne $Script:PDFStart -and $Script:PDFStart['Start']) {
        $Settings = [PSCustomObject] @{
            Type     = 'Table'
            Settings = @{
                DataTable = $DataTable
            }
        }
        $Settings
    } else {
        New-InteralPDFTable -DataTable $DataTable
    }
}