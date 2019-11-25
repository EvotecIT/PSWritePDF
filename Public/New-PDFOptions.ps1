function New-PDFOptions {
    [CmdletBinding()]
    param(
        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom
        #[ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize
    )

    [PSCustomObject] @{
        Type     = 'Options'
        Settings = @{
            Margins  = @{
                MarginLeft   = $MarginLeft
                MarginRight  = $MarginRight
                MarginTop    = $MarginTop
                MarginBottom = $MarginBottom
            }
            #PageSize = $PageSize
        }
    }
}

Register-ArgumentCompleter -CommandName New-PDFOptions -ParameterName PageSize -ScriptBlock $Script:PDFPageSize