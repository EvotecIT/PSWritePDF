Import-Module .\PSWritePDF.psd1 -Force

# Split PDF by fixed page count
Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output" -SplitCount 1

# Split PDF by page ranges
Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output" -PageRange '1-2','3'

# Split PDF using bookmark titles
Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output" -Bookmark 'Chapter 1','Chapter 2'

# Show a dry run without creating files
Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output" -SplitCount 1 -WhatIf

# Overwrite existing files if needed
Split-PDF -FilePath "$PSScriptRoot\SampleToSplit.pdf" -OutputFolder "$PSScriptRoot\Output" -SplitCount 1 -OutputName 'part' -Force

