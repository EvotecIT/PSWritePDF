<p align="center">
  <a href="https://dev.azure.com/evotecpl/PSWritePDF/_build/latest?definitionId=3"><img src="https://dev.azure.com/evotecpl/PSWritePDF/_apis/build/status/EvotecIT.PSWritePDF"></a>
  <a href="https://www.powershellgallery.com/packages/PSWritePDF"><img src="https://img.shields.io/powershellgallery/v/PSWritePDF.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSWritePDF"><img src="https://img.shields.io/powershellgallery/vpre/PSWritePDF.svg?label=powershell%20gallery%20preview&colorB=yellow"></a>
  <a href="https://github.com/EvotecIT/PSWritePDF"><img src="https://img.shields.io/github/license/EvotecIT/PSWritePDF.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/PSWritePDF"><img src="https://img.shields.io/powershellgallery/p/PSWritePDF.svg"></a>
  <a href="https://github.com/EvotecIT/PSWritePDF"><img src="https://img.shields.io/github/languages/top/evotecit/PSWritePDF.svg"></a>
  <a href="https://github.com/EvotecIT/PSWritePDF"><img src="https://img.shields.io/github/languages/code-size/evotecit/PSWritePDF.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSWritePDF"><img src="https://img.shields.io/powershellgallery/dt/PSWritePDF.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# PSWritePDF

**PSWritePDF is** by no means a finished product. Like with most of my modules, I build some concept that matches view on how I would like it to look, and in the next months, I will probably update its functionality to match my expectations. Since PSWritePDF is based on **iText 7** it should be possible with some work to get all that functionality into **PowerShell**. That means that this module has excellent possibilities when it comes to potential use cases.

For now, I've divided the module functionality into two categories:

- ☑ Standalone functions such as Split-PDF, Merge-PDF or Convert-PDFtoText
- ☑ Bundled functions working like PSWriteHTML where they are not supposed to be used separately mainly to create PDF files (for now)

To find out more read following blog posts:

- ☑ [Merging, splitting and creating PDF files with PowerShell](https://evotec.xyz/merging-splitting-and-creating-pdf-files-with-powershell/)

## 3rd Party Notices

This PowerShell Module uses [iText 7 Community for .NET](https://github.com/itext/itext7-dotnet) therefore the license needs to be kept the same as iText (or at least I think so). If it isn't so I would be more than happy to release my **PowerShell** code as **MIT license**. I don't intend to modify **iText7** codebase, just using it's **API**. As I'm not an expert on licensing I'm attaching some of articles I found that may make this license terms clearer.

Recommended read:

- [How do I make sure my software complies with AGPL: How can I use iText for free?](https://itextpdf.com/en/blog/technical-notes/how-do-i-make-sure-my-software-complies-agpl-how-can-i-use-itext-free)
- [Can I bundle iText with my non-commercial software?](https://itextpdf.com/en/resources/books/best-itext-questions-stack-overflow/can-i-bundle-itext-my-non-commercial-software)
- [AGPLv3 source redistribution: when does it apply to my code for a server-side Java app using an AGPL-licensed library?](https://opensource.stackexchange.com/questions/5003/agplv3-source-redistribution-when-does-it-apply-to-my-code-for-a-server-side-ja)

Other software used:

- Bouncy Castle [MIT license](https://www.bouncycastle.org/licence.html)
- Common License [Apache License 2.0](https://github.com/net-commons/common-logging/blob/master/license.txt)

All that additional software is required to work with iText and so it's part of this package.

## Installing / Updating

```powershell
Install-Module PSWritePDF -Force
```

## Changelog

- 0.0.16 - 2021.05.06
  - ☑ Added basic support for check box style form fields - added by ChrisMagnuson in [#20](https://github.com/EvotecIT/PSWritePDF/pull/20)
- 0.0.15 - 2021.03.17
  - ☑ Implemented `Set-PDFForm` and `Get-PDFFormField` - added by ChrisMagnuson in [#19](https://github.com/EvotecIT/PSWritePDF/pull/19)
- 0.0.14 - 2021.03.11
  - ☑ Improved error handling
- 0.0.13 - 2021.03.09
  - ☑ Improved error handling
- 0.0.12 - 2021.03.09
  - ☑ Removed `Exit` in favor of `return`
- 0.0.11 - 2021.03.09
  - ☑ Added `Register-PDFFont` that allows adding custom fonts (see examples for usage)
    - ☑ This also allows to use unicode chars (the built-in fonts don't seem to have unicode)
    - ☑ Usage: `Register-PDFFont -FontName 'Verdana' -FontPath 'C:\Windows\fonts\verdana.ttf' -Encoding IDENTITY_H -Cached -Default`
  - ☑ Improved `New-PDFListItem` allowing same options as `New-PDFText`
- 0.0.10 - 2020.8.3
  - ☑ Fixed issue with `New-PDFText` - problem with `Remove-EmptyValue`
- 0.0.9 - 2020.8.1
  - ☑ Fixed problem with `Remove-EmptyValue`
- 0.0.8 - 2020.7.21
  - Fixes
    - ☑ Silly mistake for processing hasthables - tnx Greyland99 [#7](https://github.com/EvotecIT/PSWritePDF/issues/7)
  - Updates
    - ☑ Module (psm1/ps1/psd1) and all it's DLL's are now signed. Hopefully it won't break anything

- 0.0.7 - 2020.05.02
  - Fixes
    - ☑ Fix for UNC paths [#4](https://github.com/EvotecIT/PSWritePDF/issues/4) - tnx sporkabob
    - ☑ Fix for `Split-PDF` not closing source file
    - ☑ Fix for `Convert-PDFToText` not closing source file

- 0.0.6 - 2020.01.14
  - Fixes
    - ☑ Added missing `[CmdletBinding()]`
    - ☑ Fixes New-PDF crash if no FilePath is given (#3)

- 0.0.5 - 2019.12.28
  - Fixes
    - ☑ Margins support in multiple scenarios
  - Additional commands
    - ☑ Get-PDF
    - ☑ Get-PDFDetails
    - ☑ Close-PDF
  - Updated iText to 7.1.9

- 0.0.4 - 2019.11.29
  - ☑ Convert-PDFToText - Fix for resolving paths properly
  - ☑ Split-PDF - fix for resolving paths properly
  - ☑ Merge-PDF - fix for resolving paths properly
- 0.0.3 - 2019.11.29
  - Fix for loading module from PowerShellGallery
