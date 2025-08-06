Import-Module .\PSWritePDF.psd1 -Force

$HTMLInput = New-HTML {
    New-HTMLText -Text 'Test 1'
    New-HTMLTable -DataTable (Get-Process | Select-Object -First 3)
}

$output = Convert-HTMLToPDF -Content $HTMLInput -OutputFilePath "$PSScriptRoot\Example10-FromHTML.pdf" -Force -Open
Write-Host "PDF saved to $output"
