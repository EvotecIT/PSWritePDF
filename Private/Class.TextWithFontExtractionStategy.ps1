Enum TextRenderMode {
    FillText = 0
    StrokeText = 1
    FillThenStrokeText = 2
    Invisible = 3
    FillTextAndAddToPathForClipping = 4
    StrokeTextAndAddToPathForClipping = 5
    FillThenStrokeTextAndAddToPathForClipping = 6
    AddTextToPaddForClipping = 7
}
class TextWithFontExtractionStategy : iText.Kernel.Pdf.Canvas.Parser.Listener.ITextExtractionStrategy {
    #HTML buffer
    [System.Text.StringBuilder] $result = [System.Text.StringBuilder]::new()

    #Store last used properties
    [iText.Kernel.Geom.Vector] $lastBaseLine
    [string] $lastFont
    [single] $lastFontSize

    RenderText([iText.Kernel.Pdf.Canvas.Parser.Data.TextRenderInfo] $renderInfo) {
        [string] $curFont = $renderInfo.GetFont().PostscriptFontName;
        #//Check if faux bold is used
        if ($renderInfo.GetTextRenderMode() -eq [int][TextRenderMode]::FillThenStrokeText) {
            $curFont += "-Bold";
        }

        #//This code assumes that if the baseline changes then we're on a newline
        [iText.Kernel.Geom.Vector] $curBaseline = $renderInfo.GetBaseline().GetStartPoint();
        [iText.Kernel.Geom.Vector] $topRight = $renderInfo.GetAscentLine().GetEndPoint();
        [iText.Kernel.Geom.Rectangle] $rect = [iText.Kernel.Geom.Rectangle]::new($curBaseline, $curBaseline, $topRight, $topRight);
        [Single] $curFontSize = $rect.Height;

        #//See if something has changed, either the baseline, the font or the font size
        if (($null -eq $this.lastBaseLine) -or ($curBaseline -ne $this.lastBaseLine) -or ($curFontSize -ne $this.lastFontSize) -or ($curFont -ne $this.lastFont)) {
            #//if we've put down at least one span tag close it
            if ($null -ne $this.lastBaseLine) {
                $this.result.AppendLine("</span>");
            }
            #//If the baseline has changed then insert a line break
            if (($null -ne $this.lastBaseLine) -and ($curBaseline -ne $this.lastBaseLine)) {
                $this.result.AppendLine("<br />");
            }
            #//Create an HTML tag with appropriate styles
            $this.result.AppendFormat("<span style=`"font-family: { 0 }; font-size: { 1 }`">", $curFont, $curFontSize);
        }
        #//Append the current text
        $this.result.Append($renderInfo.GetText());

        #//Set currently used properties
        $this.lastBaseLine = $curBaseline;
        $this.lastFontSize = $curFontSize;
        $this.lastFont = $curFont;
    }

    [string] GetResultantText() {
        #//If we wrote anything then we'll always have a missing closing tag so close it here
        if ($this.result.Length -gt 0) {
            $this.result.Append("</span>");
        }
        return $this.result.ToString();
    }
    [System.Collections.Generic.ICollection[iText.Kernel.Pdf.Canvas.Parser.EventType]] GetSupportedEvents() {
        return $null
    }
    [void] EventOccurred([iText.Kernel.Pdf.Canvas.Parser.Data.IEventData] $data, [iText.Kernel.Pdf.Canvas.Parser.EventType] $type) {
        return
    }
}