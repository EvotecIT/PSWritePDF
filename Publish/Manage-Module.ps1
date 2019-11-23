Clear-Host
Import-Module "C:\Support\GitHub\PSPublishModule\PSPublishModule.psm1" -Force

$Configuration = @{
    Information = @{
        ModuleName           = 'PSWritePDF'
        DirectoryProjects    = 'C:\Support\GitHub'
        LibrariesCore        = 'Lib\Core'
        LibrariesDefault     = 'Lib\Default'
        Manifest             = @{
            # Script module or binary module file associated with this manifest.
            RootModule           = 'PSWritePDF.psm1'
            # Minimum version of the Windows PowerShell engine required by this module
            PowerShellVersion    = '5.1'
            # Supported PSEditions
            CompatiblePSEditions = @('Desktop', 'Core')
            # ID used to uniquely identify this module
            GUID                 = '19fcb43c-d8c5-44a9-84e4-bccf29765490'
            # Version number of this module.
            ModuleVersion        = '0.0.2'
            # Author of this module
            Author               = 'Przemyslaw Klys'
            # Company or vendor of this module
            CompanyName          = 'Evotec'
            # Copyright statement for this module
            Copyright            = '(c) 2011-2019 Przemyslaw Klys. All rights reserved.'
            # Description of the functionality provided by this module
            Description          = 'Little project to create, read, modify, split, merge PDF files.'
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags                 = @('PDF', 'macOS', 'linux', 'windows')
            # A URL to the main website for this project.
            ProjectUri           = 'https://github.com/EvotecIT/PSWritePDF'

            LicenseUri           = 'https://github.com/EvotecIT/PSWritePDF/blob/master/LICENSE'

            IconUri              = 'https://evotec.xyz/wp-content/uploads/2019/11/PSWritePDF.png'

            #RequiredModules      = @(
            #    @{ ModuleName = 'PSSharedGoods'; ModuleVersion = "0.0.76"; Guid = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe' }
            #)
        }
    }
    Options     = @{
        Merge             = @{
            Sort           = 'None'
            FormatCodePSM1 = @{
                Enabled           = $true
                RemoveComments    = $false
                FormatterSettings = @{
                    IncludeRules = @(
                        'PSPlaceOpenBrace',
                        'PSPlaceCloseBrace',
                        'PSUseConsistentWhitespace',
                        'PSUseConsistentIndentation',
                        'PSAlignAssignmentStatement',
                        'PSUseCorrectCasing'
                    )

                    Rules        = @{
                        PSPlaceOpenBrace           = @{
                            Enable             = $true
                            OnSameLine         = $true
                            NewLineAfter       = $true
                            IgnoreOneLineBlock = $true
                        }

                        PSPlaceCloseBrace          = @{
                            Enable             = $true
                            NewLineAfter       = $false
                            IgnoreOneLineBlock = $true
                            NoEmptyLineBefore  = $false
                        }

                        PSUseConsistentIndentation = @{
                            Enable              = $true
                            Kind                = 'space'
                            PipelineIndentation = 'IncreaseIndentationAfterEveryPipeline'
                            IndentationSize     = 4
                        }

                        PSUseConsistentWhitespace  = @{
                            Enable          = $true
                            CheckInnerBrace = $true
                            CheckOpenBrace  = $true
                            CheckOpenParen  = $true
                            CheckOperator   = $true
                            CheckPipe       = $true
                            CheckSeparator  = $true
                        }

                        PSAlignAssignmentStatement = @{
                            Enable         = $true
                            CheckHashtable = $true
                        }

                        PSUseCorrectCasing         = @{
                            Enable = $true
                        }
                    }
                }
            }
            FormatCodePSD1 = @{
                Enabled        = $true
                RemoveComments = $false
            }
            Integrate      = @{
                ApprovedModules = @('PSSharedGoods', 'PSWriteColor', 'Connectimo', 'PSUnifi', 'PSWebToolbox', 'PSMyPassword')
            }
        }
        Standard          = @{
            FormatCodePSM1 = @{

            }
            FormatCodePSD1 = @{
                Enabled = $true
                #RemoveComments = $true
            }
        }
        ImportModules     = @{
            Self            = $true
            RequiredModules = $false
            Verbose         = $false
        }
        PowerShellGallery = @{
            ApiKey   = 'C:\Support\Important\PowerShellGalleryAPI.txt'
            FromFile = $true
        }
        GitHub            = @{
            ApiKey   = 'C:\Support\Important\GithubAPI.txt'
            FromFile = $true
            UserName = 'EvotecIT'
            #RepositoryName = 'PSWriteHTML'
        }
        Documentation     = @{
            Path       = 'Docs'
            PathReadme = 'Docs\Readme.md'
        }
    }
    Steps       = @{
        BuildModule        = @{
            Enable       = $true
            Merge        = $true
            MergeMissing = $true
            Releases     = $true
        }
        BuildDocumentation = $false
        PublishModule      = @{
            Enabled      = $false
            Prerelease   = ''
            RequireForce = $false
            GitHub       = $false
        }
    }
}

New-PrepareModule -Configuration $Configuration -Verbose