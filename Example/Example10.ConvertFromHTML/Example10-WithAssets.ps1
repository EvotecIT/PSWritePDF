$css = Join-Path $PSScriptRoot 'Example10-WithAssets.css'
$html = Join-Path $PSScriptRoot 'Example10-WithAssets.html'
$pdf = Join-Path $PSScriptRoot 'Example10-WithAssets.pdf'
Convert-HTMLToPDF -FilePath $html -OutputFilePath $pdf -BaseUri $PSScriptRoot -CssFilePath $css -Force
