Describe 'Set-PDFForm' -Tags "PDFForm" {
    New-Item -Path $PSScriptRoot -Force -ItemType Directory -Name 'Output'
    It 'Set-PDFForm with FieldNameAndValueHashTable' {
        $FilePath = [IO.Path]::Combine("$PSScriptRoot", "Output", "SampleAcroFormOutput.pdf")
        $FilePathSource = [IO.Path]::Combine("$PSScriptRoot", "Input", "SampleAcroForm.pdf")

        $FieldNameAndValueHashTable = @{
            "Text 1" = "Text 1 input"
            "Text 2" = "Text 2 input"
            "Text 3" = "Text 3 input"
            "Check Box 1 True" = $true
            "Check Box 2 False" = $false
            "Check Box 3 False" = $false
            "Check Box 4 True" = $true
            "Doesn't Exist" = "will not be used"
        }

        Set-PDFForm -SourceFilePath $FilePathSource -DestinationFilePath $FilePath -FieldNameAndValueHashTable $FieldNameAndValueHashTable -WarningAction SilentlyContinue

        $PDF = Get-PDF -FilePath $FilePath
        $AcrobatFormFields = Get-PDFFormField -PDF $PDF

        $FieldNameAndValueHashTable.Keys |
        Where-Object { $_ -Match "Text" } |
        ForEach-Object {
            $FieldName = $_
            $FieldValue = $FieldNameAndValueHashTable[$FieldName]
            $AcrobatFormFields |
            Where-Object key -eq $FieldName | 
            ForEach-Object {
                $_.Value.GetValue() 
            } |
            Should -Be $FieldValue
        }

        function ConvertTo-Boolean {
            param (
                [Parameter(Mandatory=$false,ValueFromPipeline=$true)][string] $Value
            )
            switch ($Value) {
                "y" { return $true; }
                "yes" { return $true; }
                "t" { return $true; }
                "true" { return $true; }
                "on" { return $true; }
                1 { return $true; }
                "n" { return $false; }
                "no" { return $false; }
                "f" { return $false; } 
                "false" { return $false; }
                "off" { return $false; } 
                0 { return $false; }
            }
        }

        $FieldNameAndValueHashTable.Keys |
        Where-Object { $_ -Match "Check Box" } |
        ForEach-Object {
            $FieldName = $_
            $FieldValue = $FieldNameAndValueHashTable[$FieldName]
            $AcrobatFormFields |
            Where-Object key -eq $FieldName | 
            ForEach-Object {
                $_.Value.GetValueAsString() | ConvertTo-Boolean
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
