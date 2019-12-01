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
  <a href="https://github.com/EvotecIT/PSWritePDF"><img src="https://img.shields.io/powershellgallery/dt/PSWritePDF.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# PSWritePDF

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

- 0.0.5 - Unreleased
  - Additional commands
    - Get-PDF
    - Get-PDFDetails
    - Close-PDF

- 0.0.4 - 29.11.2019
  - Convert-PDFToText - Fix for resolving paths properly
  - Split-PDF - fix for resolving paths properly
  - Merge-PDF - fix for resolving paths properly
- 0.0.3 - 29.11.2019
  - Fix for loading module from PowerShellGallery