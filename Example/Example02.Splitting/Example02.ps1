Import-Module PSWritePDF -Force

Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output"