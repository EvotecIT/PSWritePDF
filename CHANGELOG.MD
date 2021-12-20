## Changelog

#### - 0.0.18
  - Added `New-PDFImage` basic functionality
  - Added `Convert-HTMLToPDF`
  - Added `IgnoreProtection` switch to `Get-PDF`, `Convert-PDFToText`, `Merge-PDF`, `Set-PDFForm`, `Split-PDF` - thank you @mccbryan3 [#29](https://github.com/EvotecIT/PSWritePDF/pull/29)

#### - 0.0.17 - 2021.05.23
  - ☑ `Set-PDFForm` can now flatten forms with `Flatten` switch. Thank you markdem! in [#23](https://github.com/EvotecIT/PSWritePDF/pull/23)
  - ☑ Improved `Set-PDFForm` by removing Out-Null and replacing it with $null which is faster
  - ☑ Improved `Set-PDFForm` logic
#### - 0.0.16 - 2021.05.06
  - ☑ Added basic support for check box style form fields - added by ChrisMagnuson in [#20](https://github.com/EvotecIT/PSWritePDF/pull/20)
#### - 0.0.15 - 2021.03.17
  - ☑ Implemented `Set-PDFForm` and `Get-PDFFormField` - added by ChrisMagnuson in [#19](https://github.com/EvotecIT/PSWritePDF/pull/19)
#### - 0.0.14 - 2021.03.11
  - ☑ Improved error handling
#### - 0.0.13 - 2021.03.09
  - ☑ Improved error handling
#### - 0.0.12 - 2021.03.09
  - ☑ Removed `Exit` in favor of `return`
#### - 0.0.11 - 2021.03.09
  - ☑ Added `Register-PDFFont` that allows adding custom fonts (see examples for usage)
    - ☑ This also allows to use unicode chars (the built-in fonts don't seem to have unicode)
    - ☑ Usage: `Register-PDFFont -FontName 'Verdana' -FontPath 'C:\Windows\fonts\verdana.ttf' -Encoding IDENTITY_H -Cached -Default`
  - ☑ Improved `New-PDFListItem` allowing same options as `New-PDFText`
#### - 0.0.10 - 2020.8.3
  - ☑ Fixed issue with `New-PDFText` - problem with `Remove-EmptyValue`
#### - 0.0.9 - 2020.8.1
  - ☑ Fixed problem with `Remove-EmptyValue`
#### - 0.0.8 - 2020.7.21
  - Fixes
    - ☑ Silly mistake for processing hasthables - tnx Greyland99 [#7](https://github.com/EvotecIT/PSWritePDF/issues/7)
  - Updates
    - ☑ Module (psm1/ps1/psd1) and all it's DLL's are now signed. Hopefully it won't break anything

#### - 0.0.7 - 2020.05.02
  - Fixes
    - ☑ Fix for UNC paths [#4](https://github.com/EvotecIT/PSWritePDF/issues/4) - tnx sporkabob
    - ☑ Fix for `Split-PDF` not closing source file
    - ☑ Fix for `Convert-PDFToText` not closing source file

#### - 0.0.6 - 2020.01.14
  - Fixes
    - ☑ Added missing `[CmdletBinding()]`
    - ☑ Fixes New-PDF crash if no FilePath is given (#3)

#### - 0.0.5 - 2019.12.28
  - Fixes
    - ☑ Margins support in multiple scenarios
  - Additional commands
    - ☑ Get-PDF
    - ☑ Get-PDFDetails
    - ☑ Close-PDF
  - Updated iText to 7.1.9

#### - 0.0.4 - 2019.11.29
  - ☑ Convert-PDFToText - Fix for resolving paths properly
  - ☑ Split-PDF - fix for resolving paths properly
  - ☑ Merge-PDF - fix for resolving paths properly
#### - 0.0.3 - 2019.11.29
  - Fix for loading module from PowerShellGallery
