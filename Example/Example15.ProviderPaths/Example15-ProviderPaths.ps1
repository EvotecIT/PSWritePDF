# Demonstrates using PowerShell provider paths with PSWritePDF cmdlets

$null = New-Item -Path (Join-Path $PSScriptRoot 'Output') -ItemType Directory -Force
$null = New-PSDrive -Name Data -PSProvider FileSystem -Root (Join-Path $PSScriptRoot 'Output')

$path = 'Data:\provider-example.pdf'
New-PDF { New-PDFText -Text 'Provider path example' } -FilePath $path
