Import-Module .\PSWritePDF.psd1 -Force

$DataTable123 = @(
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [PSCustomObject] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
)

$DataTable1234 = @(
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
    [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }
)

$DataTable12345 = [ordered] @{ Test = 'Name'; Test2 = 'Name2'; Test3 = 'Name3' }

New-PDF {
    New-PDFText -Text 'Hello ', 'World' -Font HELVETICA, TIMES_ITALIC -FontColor GRAY, BLUE -FontBold $true, $false, $true
    New-PDFText -Text 'Testing adding text. ', 'Keep in mind that this works like array.' -Font HELVETICA -FontColor RED
    New-PDFText -Text 'This text is going by defaults.', ' This will continue...', ' and we can continue working like that.'

    New-PDFText -Text 'This table is representation of ', 'PSCustomObject', ' or other', ', ', 'standard types' -FontColor BLACK, RED, BLACK, BLACK, RED -FontBold $false, $true, $false, $false, $true

    New-PDFTable -DataTable $DataTable123

    New-PDFText -Text 'This shows how to create a list' -FontColor MAGENTA

    New-PDFList -Indent 3 {
        New-PDFListItem -Text 'Test'
        New-PDFListItem -Text '2nd'
    }

    New-PDFText -Text 'This table is representation of ', 'Array of Hashtable/OrderedDictionary' -FontColor BLACK, BLUE

    New-PDFTable -DataTable $DataTable1234

    New-PDFText -Text 'This table is representation of ', 'Hashtable/OrderedDictionary' -FontColor BLACK, BLUE

    New-PDFTable -DataTable $DataTable12345

} -FilePath "$PSScriptRoot\Example06.pdf" -Show