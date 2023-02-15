Import-Module .\PSWritePDF.psd1 -Force

# get all files to merge
$Files = Get-ChildItem -LiteralPath "C:\Temp\AllFiles" -Filter "*.pdf" -Recurse
# start with first file
$FirstFile = $Files[0].FullName
for ($i = 1; $i -lt $Files.Count; $i++) {
    # get the file to merge
    $File = $Files[$i]
    # define where to merge the file
    $OutputFile = "C:\Temp\MergedFile$i.pdf"
    Write-Host -ForegroundColor Green -Object "Merging $FirstFile and $($File.FullName) to $OutputFile"
    # merge first file with the next file
    Merge-PDF -InputFile $FirstFile, $File.FullName -OutputFile $OutputFile
    # delete the first merged file if it exists
    $OldOutputFile = "C:\Temp\MergedFile$($i-1).pdf"
    if (Test-Path -LiteralPath $OldOutputFile) {
        Remove-Item -LiteralPath $OldOutputFile
    }
    # assign the output file as the first file for the next iteration
    $FirstFile = $OutputFile
}