Import-Module .\PSWritePDF.psd1 -Force

New-HTML {
    New-HTMLTable -DataTable (Get-Process | Select-Object -First 3)
} -FilePath "$PSScriptRoot\Example10-FromFilePath.html" -Online

$output = Convert-HTMLToPDF -FilePath "$PSScriptRoot\Example10-FromFilePath.html" -OutputFilePath "$PSScriptRoot\Example10-FromFilePath.pdf" -Force -Open
Write-Host "PDF saved to $output"
