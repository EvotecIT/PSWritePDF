@{
    AliasesToExport      = @('Get-PDFConstantAction', 'Get-PDFConstantPageSize', 'Get-PDFConstantVersion')
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @('Close-PDF', 'Convert-HTMLToPDF', 'Convert-PDFToText', 'Get-PDF', 'Get-PDFAction', 'Get-PDFDetails', 'Get-PDFFormField', 'Get-PDFPageSize', 'Get-PDFVersion', 'Merge-PDF', 'New-PDF', 'New-PDFArea', 'New-PDFDocument', 'New-PDFImage', 'New-PDFInfo', 'New-PDFList', 'New-PDFListItem', 'New-PDFOptions', 'New-PDFPage', 'New-PDFTable', 'New-PDFText', 'Register-PDFFont', 'Set-PDFForm', 'Split-PDF')
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2025 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Little project to create, read, modify, split, merge PDF files on Windows, Linux and Mac.'
    FunctionsToExport    = @()
    GUID                 = '19fcb43c-d8c5-44a9-84e4-bccf29765490'
    ModuleVersion        = '1.0.0'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2019/11/PSWritePDF.png'
            LicenseUri = 'https://github.com/EvotecIT/PSWritePDF/blob/master/LICENSE'
            ProjectUri = 'https://github.com/EvotecIT/PSWritePDF'
            Tags       = @('PDF', 'macOS', 'linux', 'windows')
        }
    }
    RootModule           = 'PSWritePDF.psm1'
}