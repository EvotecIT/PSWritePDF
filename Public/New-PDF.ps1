function New-PDF {
    [CmdletBinding()]
    param(
        [scriptblock] $PDFContent,
        [string] $FilePath,
        [string] $Version,

        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom,
        [ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize,
        [switch] $Rotate,

        [alias('Open')][switch] $Show
    )
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
        FirstPageUsed    = $false
    }
    if ($PDFContent) {
        [Array] $Elements = @(
            #$FirstPage
            [Array] $Content = & $PDFContent
            #if ($Content[0].Type -eq 'Page') {
            #$Content | Select-Object -Skip 1
            #$PageSize = $Content[0].Settings.PageSize
            #$Rotate = $Content[0].Settings.Rotate
            #     $Script:PDFStart.SkipFirstPage = $true
            #}
            if ($Content.Type -notcontains 'Page') {
                New-PDFPage -PageSize $PageSize -Rotate:$Rotate
            }
            $Content

        )
        $Script:PDF = New-InternalPDF -FilePath $FilePath -Version $Version -PageSize $PageSize -Rotate:$Rotate
    } else {
        $Script:PDFStart['Start'] = $false
        # if there's no scriptblock that means we're using standard way of working with PDF
        $Script:PDF = New-InternalPDF -FilePath $FilePath -Version $Version -PageSize $PageSize -Rotate:$Rotate
        return $Script:PDF
    }

    $Script:PDFStart['Start'] = $true
    $Script:Document = New-PDFDocument -PDF $Script:PDF
    New-InternalPDFOptions -MarginLeft $MarginLeft -MarginRight $MarginRight -MarginTop $MarginTop -MarginBottom $MarginBottom

    Initialize-PDF -Elements $Elements
    if ($Script:PDF) {
        $Script:PDF.Close();
    }
    if ($Show) {
        if (Test-Path -LiteralPath $FilePath) {
            Invoke-Item -LiteralPath $FilePath
        }
    }
    $Script:PDFStart['Start'] = $false
}

Register-ArgumentCompleter -CommandName New-PDF -ParameterName PageSize -ScriptBlock $Script:PDFPageSize
Register-ArgumentCompleter -CommandName New-PDF -ParameterName Version -ScriptBlock $Script:PDFVersion