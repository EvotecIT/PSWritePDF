function New-InternalPDF {
    [CmdletBinding()]
    param(
        [string] $FilePath,
        [string] $Version #,
        #  [ValidateScript( { & $Script:PDFPageSizeValidation } )][string] $PageSize,
        #   [switch] $Rotate
    )

    if ($Version) {
        $PDFVersion = Get-PDFConstantVersion -Version $Version
        $WriterProperties = [iText.Kernel.Pdf.WriterProperties]::new()
        $null = $WriterProperties.SetPdfVersion($PDFVersion)
    }

    try {
        if ($Version) {
            $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($FilePath, $WriterProperties)
        } else {
            $Script:Writer = [iText.Kernel.Pdf.PdfWriter]::new($FilePath)
        }
    } catch {
        if ($_.Exception.Message -like '*The process cannot access the file*because it is being used by another process.*') {
            Write-Warning "New-InternalPDF - File $FilePath is in use. Terminating."
            return
        } else {
            Write-Warning "New-InternalPDF - Terminating error: $($_.Exception.Message)"
            return
        }
    }

    if ($Script:Writer) {
        $PDF = [iText.Kernel.Pdf.PdfDocument]::new($Script:Writer)
    } else {
        Write-Warning "New-InternalPDF - Terminating as writer doesn't exists."
        return
    }
    return $PDF
}



<#
function New-InternalPDF {
    param(

    )
    if ($Script:Writer) {
        if ($Script:PDF) {
            #$Script:PDF.Close()
        }
        $Script:PDF = [iText.Kernel.Pdf.PdfDocument]::new($Script:Writer)
    } else {
        Write-Warning "New-InternalPDF - Terminating as writer doesn't exists."
        Exit
    }
}
#>
Register-ArgumentCompleter -CommandName New-InternalPDF -ParameterName PageSize -ScriptBlock $Script:PDFPageSize
Register-ArgumentCompleter -CommandName New-InternalPDF -ParameterName Version -ScriptBlock $Script:PDFVersion