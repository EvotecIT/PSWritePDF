
function New-PDFPage {
    param(
        [ScriptBlock] $PageContent,
        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom,
        [ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize,
        [switch] $Rotate
    )

    $Page = [PSCustomObject] @{
        Type     = 'Page'
        Settings = @{
            Margins  = @{
                Left   = $MarginLeft
                Right  = $MarginRight
                Top    = $MarginTop
                Bottom = $MarginBottom
            }
            PageSize = $PageSize
            Rotate   = $Rotate.IsPresent
        }
    }
    $Page
}

Register-ArgumentCompleter -CommandName New-PDFPage -ParameterName PageSize -ScriptBlock $Script:PDFPageSize