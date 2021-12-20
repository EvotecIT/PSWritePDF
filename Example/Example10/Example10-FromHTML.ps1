Import-Module .\PSWritePDF.psd1 -Force

$HTMLInput = New-HTML {
    New-HTMLTable -DataTable (Get-Process | Select-Object -First 3)
}

Convert-HTMLToPDF -Content $HTMLInput -OutputFilePath "$PSScriptRoot\Example10-FromHTML.pdf" -Open