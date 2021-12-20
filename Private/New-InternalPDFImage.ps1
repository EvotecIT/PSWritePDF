function New-InternalPDFImage {
    [CmdletBinding()]
    param(
        [string] $ImagePath,
        [int] $Width,
        [int] $Height,
        [object] $BackgroundColor,
        [double] $BackgroundColorOpacity
    )

    $ImageData = [iText.IO.Image.ImageDataFactory]::Create($ImagePath)
    $Image = [iText.Layout.Element.Image]::new($ImageData)

    if ($Width) {
        $Image.SetWidth($Width)
    }
    if ($Height) {
        $Image.SetHeight($Height)

    }
    if ($BackgroundColor) {
        <#
        iText.Layout.Element.Image SetBackgroundColor(iText.Kernel.Colors.Color backgroundColor)
        iText.Layout.Element.Image SetBackgroundColor(iText.Kernel.Colors.Color backgroundColor, float opacity)
        iText.Layout.Element.Image SetBackgroundColor(iText.Kernel.Colors.Color backgroundColor, float extraLeft, float extraTop, float extraRight, float extraBottom)
        iText.Layout.Element.Image SetBackgroundColor(iText.Kernel.Colors.Color backgroundColor, float opacity, float extraLeft, float extraTop, float extraRight, float extraBottom)
        #>
        $RGB = [iText.Kernel.Colors.DeviceRgb]::new($BackgroundColor.R, $BackgroundColor.G, $BackgroundColor.B)
        $null = $Image.SetBackgroundColor($RGB)
        if ($BackgroundColorOpacity) {
            $null = $Image.SetOpacity($BackgroundColorOpacity)
        }
    }
    $null = $Script:Document.Add($Image)
}