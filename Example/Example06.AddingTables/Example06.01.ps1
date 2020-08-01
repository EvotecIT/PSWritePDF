Import-Module .\PSWritePDF.psd1 -Force

$Data1 = @(
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
)

$Data2 = @(
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
)
$Data3 = [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }

$FilePath = [IO.Path]::Combine("$PSScriptRoot", 'Example06.01.pdf')
New-PDF {
    New-PDFTable -DataTable $Data1
    New-PDFTable -DataTable $Data2
} -FilePath $FilePath

Close-PDF -Document $Document