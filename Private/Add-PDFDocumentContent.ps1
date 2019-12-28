function Add-PDFDocumentContent {
    [CmdletBinding()]
    param(
        [object] $Object
    )
    if ($Script:Document) {
        $null = $Script:Document.Add($Object)
    } else {
        $Splat = $Script:PDFStart.DocumentSettings
        $Settings = New-PDFPage @Splat #-MarginTop $MarginTop -MarginBottom $MarginBottom -MarginLeft $MarginLeft -MarginRight $MarginRight -PageSize $PageSize -Rotate:$Rotate.IsPresent
        New-InternalPDFPage -PageSize $Settings.Settings.PageSize -Rotate:$Settings.Settings.Rotate -MarginTop $MarginTop -MarginBottom $MarginBottom -MarginLeft $MarginLeft -MarginRight $MarginRight
        $null = $Script:Document.Add($Object)
    }
}