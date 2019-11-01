function Merge-PDF {
    [CmdletBinding()]
    param(
        [string[]] $InputFile,
        [string] $OutputFile
    )

    [iText.Kernel.Pdf.PdfWriter] $Writer = [iText.Kernel.Pdf.PdfWriter]::new($OutputFile)
    [iText.Kernel.Pdf.PdfDocument] $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Writer);
    [iText.Kernel.Utils.PdfMerger] $Merger = [iText.Kernel.Utils.PdfMerger]::new($pdf)

    foreach ($File in $InputFile) {
        #//Add pages from the first document
        $Source = [iText.Kernel.Pdf.PdfReader]::new($File)
        [iText.Kernel.Pdf.PdfDocument] $SourcePDF = [iText.Kernel.Pdf.PdfDocument]::new($Source);
        $null = $Merger.merge($SourcePDF, 1, $SourcePDF.getNumberOfPages())
        $SourcePDF.close()
    }
    $PDF.Close()
}