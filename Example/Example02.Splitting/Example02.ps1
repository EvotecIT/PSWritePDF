Import-Module .\PSWritePDF.psd1 -Force

Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output"

Split-PDF -FilePath "\\ad1\c$\SampleToSplit.pdf" -OutputFolder "\\ad1\c$\Output"