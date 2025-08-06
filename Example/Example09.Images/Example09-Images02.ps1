Import-Module .\PSWritePDF.psd1 -Force

# Example showing returned image object
New-PDF {
    $img = New-PDFImage -ImagePath "$PSScriptRoot\Evotec-Logo-600x190.png"
    Write-Host "Image type: $($img.GetType().FullName)"
} -FilePath "$PSScriptRoot\Example09-Images02.pdf" -Show

# Example handling missing image path
try {
    New-PDF {
        New-PDFImage -ImagePath "$PSScriptRoot\Missing.png"
    } -FilePath "$PSScriptRoot\Example09-Images-Missing.pdf" -Show
} catch {
    Write-Warning $_.Exception.Message
}

