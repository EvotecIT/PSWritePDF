class CustomSplitter : iText.Kernel.Utils.PdfSplitter {
    [int] $_order
    [string] $_destinationFolder
    [string] $_outputName

    CustomSplitter([iText.Kernel.Pdf.PdfDocument] $pdfDocument, [string] $destinationFolder, [string] $OutputName) : base($pdfDocument) {
        $this._destinationFolder = $destinationFolder
        $this._order = 0
        $this._outputName = $OutputName
    }

    [iText.Kernel.Pdf.PdfWriter] GetNextPdfWriter([iText.Kernel.Utils.PageRange] $documentPageRange) {
        $Name = -join ($this._outputName, $this._order++, ".pdf")
        $Path = [IO.Path]::Combine($this._destinationFolder, $Name)
        return [iText.Kernel.Pdf.PdfWriter]::new($Path)
    }
}

# [iText.Kernel.Geom.Vector]::I1
<#
    RenderText([iText.Kernel.Pdf.Canvas.Parser.Data.TextRenderInfo] $renderInfo) {
        [string] $curFont = $renderInfo.GetFont().PostscriptFontName
        #//Check if faux bold is used
        if ((renderInfo.GetTextRenderMode() == (int)TextRenderMode.FillThenStrokeText)) {
            $curFont += "-Bold";
        }

        #//This code assumes that if the baseline changes then we're on a newline
        [iText.Kernel.Geom.Vector] $curBaseline = $renderInfo.GetBaseline().GetStartPoint();
        [iText.Kernel.Geom.Vector] $topRight = $renderInfo.GetAscentLine().GetEndPoint();
        [iText.Kernel.Geom.Rectangle] $rect = [iText.Kernel.Geom.Rectangle]::new($curBaseline[Vector.I1], $curBaseline[Vector.I2], $topRight[Vector.I1], $topRight[Vector.I2]);
        [Single] $curFontSize = $rect.Height;

        #//See if something has changed, either the baseline, the font or the font size
        if (($this.lastBaseLine -eq $null) -or ($curBaseline[Vector.I2] -ne $lastBaseLine[Vector.I2]) -or ($curFontSize -ne $lastFontSize) -or ($curFont -ne $lastFont)) {
            #//if we've put down at least one span tag close it
            if (($this.lastBaseLine -ne $null)) {
                $this.result.AppendLine("</span>");
            }
            #//If the baseline has changed then insert a line break
            if (($this.lastBaseLine -ne $null) -and ($curBaseline[Vector.I2] -ne $lastBaseLine[Vector.I2]) {
                $this.result.AppendLine("<br />");
            }
            #//Create an HTML tag with appropriate styles
            $this.result.AppendFormat("<span style=`"font-family: { 0 }; font-size: { 1 }`">", $curFont, $curFontSize);
        }
        #//Append the current text
        $this.result.Append($renderInfo.GetText());

        #//Set currently used properties
        $this.lastBaseLine = curBaseline;
        $this.lastFontSize = curFontSize;
        $this.lastFont = curFont;
    }
#>