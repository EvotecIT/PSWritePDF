Import-Module .\PSWritePDF.psd1 -Force

Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output"