function New-PDFImage {
    [CmdletBinding()]
    param(
        [string] $ImagePath,
        [int] $Width,
        [int] $Height,
        [string] $BackgroundColor,
        [double] $BackgroundColorOpacity
    )

    [PSCustomObject] @{
        Type     = 'Image'
        Settings = @{
            ImagePath              = $ImagePath
            Width                  = $Width
            Height                 = $Height
            BackgroundColor        = ConvertFrom-Color -Color $BackgroundColor -AsDrawingColor
            BackgroundColorOpacity = $BackgroundColorOpacity
        }
    }
}

Register-ArgumentCompleter -CommandName New-PDFImage -ParameterName BackgroundColor -ScriptBlock $Script:ScriptBlockColors