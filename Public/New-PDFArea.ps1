function New-PDFArea {
    [CmdletBinding()]
    param(
        [iText.Layout.Properties.AreaBreakType] $AreaType = [iText.Layout.Properties.AreaBreakType]::NEXT_AREA,
        [string] $PageSize,
        [switch] $Rotate
    )
    # https://api.itextpdf.com/iText7/dotnet/7.1.8/classi_text_1_1_kernel_1_1_geom_1_1_page_size.html
    $AreaBreak = [iText.Layout.Element.AreaBreak]::new($AreaType)
    if ($PageSize) {
        $Page = [iText.Kernel.Geom.PageSize]::($PageSize)
    } else {
        $Page = [iText.Kernel.Geom.PageSize]::Default
    }
    if ($Rotate) {
        $Page = $Page.Rotate()
    }
    $AreaBreak.SetPageSize($Page)
    return $AreaBreak
}

Register-ArgumentCompleter -CommandName New-PDFArea  -ParameterName PageSize -ScriptBlock $Script:PDFPageSize

<#
   TypeName: iText.Layout.Element.AreaBreak

Name                       MemberType Definition
----                       ---------- ----------
AddStyle                   Method     iText.Layout.Element.AreaBreak AddStyle(iText.Layout.Style style)
CreateRendererSubTree      Method     iText.Layout.Renderer.IRenderer CreateRendererSubTree(), iText.Layout.Renderer.IRenderer IElement.CreateRendererSubTree()
DeleteOwnProperty          Method     void DeleteOwnProperty(int property), void IPropertyContainer.DeleteOwnProperty(int property)
Equals                     Method     bool Equals(System.Object obj)
GetAreaType                Method     System.Nullable[iText.Layout.Properties.AreaBreakType] GetAreaType()
GetChildren                Method     System.Collections.Generic.IList[iText.Layout.Element.IElement] GetChildren()
GetDefaultProperty         Method     T1 GetDefaultProperty[T1](int property), T1 IPropertyContainer.GetDefaultProperty[T1](int property)
GetHashCode                Method     int GetHashCode()
GetOwnProperty             Method     T1 GetOwnProperty[T1](int property), T1 IPropertyContainer.GetOwnProperty[T1](int property)
GetPageSize                Method     iText.Kernel.Geom.PageSize GetPageSize()
GetProperty                Method     T1 GetProperty[T1](int property), T1 IPropertyContainer.GetProperty[T1](int property)
GetRenderer                Method     iText.Layout.Renderer.IRenderer GetRenderer(), iText.Layout.Renderer.IRenderer IElement.GetRenderer()
GetSplitCharacters         Method     iText.Layout.Splitting.ISplitCharacters GetSplitCharacters()
GetStrokeColor             Method     iText.Kernel.Colors.Color GetStrokeColor()
GetStrokeWidth             Method     System.Nullable[float] GetStrokeWidth()
GetTextRenderingMode       Method     System.Nullable[int] GetTextRenderingMode()
GetType                    Method     type GetType()
HasOwnProperty             Method     bool HasOwnProperty(int property), bool IPropertyContainer.HasOwnProperty(int property)
HasProperty                Method     bool HasProperty(int property), bool IPropertyContainer.HasProperty(int property)
IsEmpty                    Method     bool IsEmpty()
SetAction                  Method     iText.Layout.Element.AreaBreak SetAction(iText.Kernel.Pdf.Action.PdfAction action)
SetBackgroundColor         Method     iText.Layout.Element.AreaBreak SetBackgroundColor(iText.Kernel.Colors.Color backgroundColor), iText.Layout.Element.AreaBreak SetBackgroun...
SetBaseDirection           Method     iText.Layout.Element.AreaBreak SetBaseDirection(System.Nullable[iText.Layout.Properties.BaseDirection] baseDirection)
SetBold                    Method     iText.Layout.Element.AreaBreak SetBold()
SetBorder                  Method     iText.Layout.Element.AreaBreak SetBorder(iText.Layout.Borders.Border border)
SetBorderBottom            Method     iText.Layout.Element.AreaBreak SetBorderBottom(iText.Layout.Borders.Border border)
SetBorderBottomLeftRadius  Method     iText.Layout.Element.AreaBreak SetBorderBottomLeftRadius(iText.Layout.Properties.BorderRadius borderRadius)
SetBorderBottomRightRadius Method     iText.Layout.Element.AreaBreak SetBorderBottomRightRadius(iText.Layout.Properties.BorderRadius borderRadius)
SetBorderLeft              Method     iText.Layout.Element.AreaBreak SetBorderLeft(iText.Layout.Borders.Border border)
SetBorderRadius            Method     iText.Layout.Element.AreaBreak SetBorderRadius(iText.Layout.Properties.BorderRadius borderRadius)
SetBorderRight             Method     iText.Layout.Element.AreaBreak SetBorderRight(iText.Layout.Borders.Border border)
SetBorderTop               Method     iText.Layout.Element.AreaBreak SetBorderTop(iText.Layout.Borders.Border border)
SetBorderTopLeftRadius     Method     iText.Layout.Element.AreaBreak SetBorderTopLeftRadius(iText.Layout.Properties.BorderRadius borderRadius)
SetBorderTopRightRadius    Method     iText.Layout.Element.AreaBreak SetBorderTopRightRadius(iText.Layout.Properties.BorderRadius borderRadius)
SetCharacterSpacing        Method     iText.Layout.Element.AreaBreak SetCharacterSpacing(float charSpacing)
SetDestination             Method     iText.Layout.Element.AreaBreak SetDestination(string destination)
SetFixedPosition           Method     iText.Layout.Element.AreaBreak SetFixedPosition(float left, float bottom, float width), iText.Layout.Element.AreaBreak SetFixedPosition(f...
SetFont                    Method     iText.Layout.Element.AreaBreak SetFont(iText.Kernel.Font.PdfFont font), iText.Layout.Element.AreaBreak SetFont(string font)
SetFontColor               Method     iText.Layout.Element.AreaBreak SetFontColor(iText.Kernel.Colors.Color fontColor), iText.Layout.Element.AreaBreak SetFontColor(iText.Kerne...
SetFontFamily              Method     iText.Layout.Element.AreaBreak SetFontFamily(Params string[] fontFamilyNames), iText.Layout.Element.AreaBreak SetFontFamily(System.Collec...
SetFontKerning             Method     iText.Layout.Element.AreaBreak SetFontKerning(iText.Layout.Properties.FontKerning fontKerning)
SetFontScript              Method     iText.Layout.Element.AreaBreak SetFontScript(System.Nullable[iText.IO.Util.UnicodeScript] script)
SetFontSize                Method     iText.Layout.Element.AreaBreak SetFontSize(float fontSize)
SetHorizontalAlignment     Method     iText.Layout.Element.AreaBreak SetHorizontalAlignment(System.Nullable[iText.Layout.Properties.HorizontalAlignment] horizontalAlignment)
SetHyphenation             Method     iText.Layout.Element.AreaBreak SetHyphenation(iText.Layout.Hyphenation.HyphenationConfig hyphenationConfig)
SetItalic                  Method     iText.Layout.Element.AreaBreak SetItalic()
SetLineThrough             Method     iText.Layout.Element.AreaBreak SetLineThrough()
SetNextRenderer            Method     void SetNextRenderer(iText.Layout.Renderer.IRenderer renderer), void IElement.SetNextRenderer(iText.Layout.Renderer.IRenderer renderer)
SetOpacity                 Method     iText.Layout.Element.AreaBreak SetOpacity(System.Nullable[float] opacity)
SetPageNumber              Method     iText.Layout.Element.AreaBreak SetPageNumber(int pageNumber)
SetPageSize                Method     void SetPageSize(iText.Kernel.Geom.PageSize pageSize)
SetProperty                Method     void SetProperty(int property, System.Object value), void IPropertyContainer.SetProperty(int property, System.Object value)
SetRelativePosition        Method     iText.Layout.Element.AreaBreak SetRelativePosition(float left, float top, float right, float bottom)
SetSplitCharacters         Method     iText.Layout.Element.AreaBreak SetSplitCharacters(iText.Layout.Splitting.ISplitCharacters splitCharacters)
SetStrokeColor             Method     iText.Layout.Element.AreaBreak SetStrokeColor(iText.Kernel.Colors.Color strokeColor)
SetStrokeWidth             Method     iText.Layout.Element.AreaBreak SetStrokeWidth(float strokeWidth)
SetTextAlignment           Method     iText.Layout.Element.AreaBreak SetTextAlignment(System.Nullable[iText.Layout.Properties.TextAlignment] alignment)
SetTextRenderingMode       Method     iText.Layout.Element.AreaBreak SetTextRenderingMode(int textRenderingMode)
SetUnderline               Method     iText.Layout.Element.AreaBreak SetUnderline(), iText.Layout.Element.AreaBreak SetUnderline(float thickness, float yPosition), iText.Layou...
SetWordSpacing             Method     iText.Layout.Element.AreaBreak SetWordSpacing(float wordSpacing)
ToString                   Method     string ToString()
#>