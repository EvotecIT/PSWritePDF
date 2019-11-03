function New-PDF {
    [CmdletBinding()]
    param(
        [scriptblock] $PDFContent,
        [string] $FilePath,

        [nullable[float]] $MarginLeft,
        [nullable[float]] $MarginRight,
        [nullable[float]] $MarginTop,
        [nullable[float]] $MarginBottom,
        [ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize,
        [switch] $Rotate,

        [alias('Open')][switch] $Show
    )
    $Script:PDFStart = @{
        Start = $true
    }

    New-InternalPDF -FilePath $FilePath
    $FirstPage = New-PDFPage -MarginTop $MarginTop -MarginBottom $MarginBottom -MarginLeft $MarginLeft -MarginRight $MarginRight -PageSize $PageSize -Rotate:$Rotate.IsPresent
    [Array] $Output = @(
        $FirstPage
        & $PDFContent
    )
    foreach ($Element in $Output) {
        if ($Element.Type -eq 'Page') {
            New-InternalPDFPage -Settings $Element.Settings
        }
        if ($Element.Type -eq 'Text') {
            $Paragraph = New-InternalPDFText -Settings $Element.Settings
            foreach ($P in $Paragraph) {
                $null = $Script:Document.Add($P)
            }
        }
        if ($Element.Type -eq 'List') {
            New-InternalPDFList -Settings $Element.Settings
        }
        if ($Element.Type -eq 'Paragraph') {

        }
        if ($Element.Type -eq 'Options') {
            New-InternalPDFOptions -Settings $Element.Settings
        }

    }

    $Script:PDF.Close();
    if ($Show) {
        if (Test-Path -LiteralPath $FilePath) {
            Invoke-Item -LiteralPath $FilePath
        }
    }
    $Script:PDFStart['Start'] = $false
}

Register-ArgumentCompleter -CommandName New-PDF -ParameterName PageSize -ScriptBlock $Script:PDFPageSize