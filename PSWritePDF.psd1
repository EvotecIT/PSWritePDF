@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2021 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Little project to create, read, modify, split, merge PDF files on Windows, Linux and Mac.'
    FunctionsToExport    = @('Close-PDF', 'Get-PDF', 'Get-PDFDetails', 'Get-PDFFormField', 'New-PDF', 'New-PDFArea', 'New-PDFDocument', 'New-PDFImage', 'New-PDFInfo', 'New-PDFList', 'New-PDFListItem', 'New-PDFOptions', 'New-PDFPage', 'New-PDFTable', 'New-PDFText', 'Register-PDFFont', 'Get-PDFConstantAction', 'Get-PDFConstantColor', 'Get-PDFConstantFont', 'Get-PDFConstantPageSize', 'Get-PDFConstantVersion', 'Convert-HTMLToPDF', 'Convert-PDFToText', 'Merge-PDF', 'Set-PDFForm', 'Split-PDF')
    GUID                 = '19fcb43c-d8c5-44a9-84e4-bccf29765490'
    ModuleVersion        = '0.0.18'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags       = @('PDF', 'macOS', 'linux', 'windows')
            LicenseUri = 'https://github.com/EvotecIT/PSWritePDF/blob/master/LICENSE'
            ProjectUri = 'https://github.com/EvotecIT/PSWritePDF'
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2019/11/PSWritePDF.png'
        }
    }
    RequiredModules      = @(@{
            ModuleVersion = '0.0.215'
            ModuleName    = 'PSSharedGoods'
            Guid          = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'
        })
    RootModule           = 'PSWritePDF.psm1'
}