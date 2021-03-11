function New-PDF {
    [CmdletBinding()]
    param(
        [scriptblock] $PDFContent,
        [Parameter(Mandatory)][string] $FilePath,
        [string] $Version,

        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom,
        [ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize,
        [switch] $Rotate,

        [alias('Open')][switch] $Show
    )
    # The types needs filling in for the workaround below. DONT FORGET!
    $Script:Types = 'Text', 'List', 'Paragraph', 'Table', 'Image'
    $Script:PDFStart = @{
        Start            = $true
        FilePath         = $FilePath
        DocumentSettings = @{
            MarginTop    = $MarginTop
            MarginBottom = $MarginBottom
            MarginLeft   = $MarginLeft
            MarginRight  = $MarginRight
            PageSize     = $PageSize
            Rotate       = $Rotate.IsPresent
        }
        FirstPageFound   = $false
        FirstPageUsed    = $false
        UsedTypes        = [System.Collections.Generic.List[string]]::new()
    }
    if ($PDFContent) {
        [Array] $Elements = @(
            [Array] $Content = & $PDFContent
            # This is workaround to support multiple scenarios:
            # New-PDF { New-PDFPage, New-PDFPage }
            # New-PDF { }
            # New-PDF { New-PDFText, New-PDFPage }
            # This is there to make sure we allow for New-PDF to allow control for -Rotate/PageSize to either whole document or to text/tables
            # and other types until New-PDFPage is given
            # It's ugly but seems to wrok
            foreach ($_ in $Content) {
                if ($_.Type -in $Script:Types) {
                    $Script:PDFStart.UsedTypes.Add($_.Type)
                } elseif ($_.Type -eq 'Page') {
                    if ($Script:PDFStart.UsedTypes.Count -ne 0) {
                        New-PDFPage -PageSize $PageSize -Rotate:$Rotate -MarginLeft $MarginLeft -MarginTop $MarginTop -MarginBottom $MarginBottom -MarginRight $MarginRight
                        $Script:PDFStart.FirstPageFound = $true
                    }
                    break
                }
            }
            if (-not $Script:PDFStart.FirstPageFound -and $Script:PDFStart.UsedTypes.Count -ne 0) {
                New-PDFPage -PageSize $PageSize -Rotate:$Rotate -MarginLeft $MarginLeft -MarginTop $MarginTop -MarginBottom $MarginBottom -MarginRight $MarginRight
                $Script:PDFStart.FirstPageFound = $true
            }
            $Content
        )
        if ($Elements) {
            $Script:PDF = New-InternalPDF -FilePath $FilePath -Version $Version #-PageSize $PageSize -Rotate:$Rotate
            if (-not $Script:PDF) {
                return
            }
        } else {
            Write-Warning "New-PDF - No content was provided. Terminating."
            return
        }
    } else {
        $Script:PDFStart['Start'] = $false
        # if there's no scriptblock that means we're using standard way of working with PDF
        $Script:PDF = New-InternalPDF -FilePath $FilePath -Version $Version #-PageSize $PageSize -Rotate:$Rotate
        return $Script:PDF
    }

    $Script:PDFStart['Start'] = $true
    #[iText.Layout.Document] $Script:Document = New-PDFDocument -PDF $Script:PDF
    #New-InternalPDFOptions -MarginLeft $MarginLeft -MarginRight $MarginRight -MarginTop $MarginTop -MarginBottom $MarginBottom

    Initialize-PDF -Elements $Elements
    if ($Script:Document) {
        $Script:Document.Close();
    }
    if ($Show) {
        if (Test-Path -LiteralPath $FilePath) {
            Invoke-Item -LiteralPath $FilePath
        }
    }
    $Script:PDFStart = $null
    #$Script:PDFStart['Start'] = $false
}

Register-ArgumentCompleter -CommandName New-PDF -ParameterName PageSize -ScriptBlock $Script:PDFPageSize
Register-ArgumentCompleter -CommandName New-PDF -ParameterName Version -ScriptBlock $Script:PDFVersion