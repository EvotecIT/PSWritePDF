$PSVersionTable.PSVersion

$ModuleName = (Get-ChildItem $PSScriptRoot\*.psd1).BaseName
$RequiredModules = @(
    'Pester'
    'PSSharedGoods'
)
foreach ($_ in $RequiredModules) {
    if ($null -eq (Get-Module -ListAvailable $_)) {
        Write-Warning "$ModuleName - Downloading $_ from PSGallery"
        Install-Module -Name $_ -Repository PSGallery -Force -SkipPublisherCheck
    }
    Write-Warning "Importing module $_"
    Import-Module $_ -Force
}

Import-Module $PSScriptRoot\PSWritePDF.psd1 -Force -Verbose

$result = Invoke-Pester -Script $PSScriptRoot\Tests -Verbose -EnableExit

if ($result.FailedCount -gt 0) {
    throw "$($result.FailedCount) tests failed."
}