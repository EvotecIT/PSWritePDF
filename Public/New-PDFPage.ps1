function New-PDFPage {
    [CmdletBinding()]
    param(
        [ScriptBlock] $PageContent,
        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom,
        [ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize,
        [switch] $Rotate
    )
    if ($null -ne $Script:PDFStart -and $Script:PDFStart['Start']) {
        $Page = [PSCustomObject] @{
            Type     = 'Page'
            Settings = @{
                Margins     = @{
                    MarginLeft   = $MarginLeft
                    MarginRight  = $MarginRight
                    MarginTop    = $MarginTop
                    MarginBottom = $MarginBottom
                }
                PageSize    = $PageSize
                Rotate      = $Rotate.IsPresent
                PageContent = if ($PageContent) { & $PageContent } else { $null }
            }
        }
        $Page
    } else {
        # New-InternalPDFPage -PageSize $PageSize -Rotate:$Rotate.IsPresent
    }
}

Register-ArgumentCompleter -CommandName New-PDFPage -ParameterName PageSize -ScriptBlock $Script:PDFPageSize