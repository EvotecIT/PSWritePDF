Describe 'Set-PDFForm' -Tags "PDFForm" {
    New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output'
    It 'Set-PDFForm with FieldNameAndValueHashTable' {
        $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "SampleAcroFormOutput.pdf")

        $FieldNameAndValueHashTable = @{
            "Text 1" = "Text 1 input"
            "Text 2" = "Text 2 input"
            "Text 3" = "Text 3 input"
        }

        Set-PDFForm -SourceFilePath $PSScriptRoot\Input\SampleAcroForm.pdf -DestinationFilePath $FilePath -FieldNameAndValueHashTable $FieldNameAndValueHashTable

        $PDF = Get-PDF -FilePath $FilePath
        $AcrobatFormFields = Get-PDFFormField -PDF $PDF

        foreach ($FieldName in $FieldNameAndValueHashTable.Keys) {
            $FieldValue = $FieldNameAndValueHashTable[$FieldName]
            $AcrobatFormFields |
            Where-Object key -eq $FieldName | 
            ForEach-Object {
                $_.Value.GetValue() 
            } |
            Should -Be $FieldValue
        }

        Close-PDF -Document $PDF
    }

    # cleanup
    $FolderPath = [IO.Path]::Combine("$PSScriptRoot", "Output")
    $Files = Get-ChildItem -LiteralPath $FolderPath -File
    foreach ($_ in $Files) {
        Remove-Item -LiteralPath $_.FullName -ErrorAction SilentlyContinue
    }
}