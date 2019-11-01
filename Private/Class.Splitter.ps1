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