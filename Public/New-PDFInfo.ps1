function New-PDFInfo {
    [CmdletBinding()]
    param(
        [iText.Kernel.Pdf.PdfDocument] $PDF,
        [string] $Title,
        [string] $Author,
        [string] $Creator,
        [string] $Subject,
        [string[]] $Keywords,
        [switch] $AddCreationDate,
        [switch] $AddModificationDate
    )

    try {
        [iText.Kernel.Pdf.PdfDocumentInfo] $info = $pdf.GetDocumentInfo()
    } catch {
        Write-Warning "New-PDFInfo - Error: $($_.Exception.Message)"
        return
    }

    if ($Title) {
        $null = $info.SetTitle($Title)
    }
    if ($AddCreationDate) {
        $null = $info.AddCreationDate()
    }
    if ($AddModificationDate) {
        $null = $info.AddModDate()
    }
    if ($Author) {
        $null = $info.SetAuthor($Author)
    }
    if ($Creator) {
        $null = $info.SetCreator($Creator)
    }
    if ($Subject) {
        $null = $info.SetSubject($Subject)
    }
    if ($Keywords) {
        $KeywordsString = $Keywords -join ','
        $null = $info.SetKeywords($KeywordsString)
    }
}