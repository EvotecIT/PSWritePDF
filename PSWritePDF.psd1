﻿#
# Module manifest for module 'PSWritePDF'
#
# Generated by: Przemyslaw Klys
#
# Generated on: 29.11.2019
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'PSWritePDF.psm1'

    # Version number of this module.
    ModuleVersion        = '0.0.4'

    # Supported PSEditions
    CompatiblePSEditions = 'Desktop', 'Core'

    # ID used to uniquely identify this module
    GUID                 = '19fcb43c-d8c5-44a9-84e4-bccf29765490'

    # Author of this module
    Author               = 'Przemyslaw Klys'

    # Company or vendor of this module
    CompanyName          = 'Evotec'

    # Copyright statement for this module
    Copyright            = '(c) 2011-2019 Przemyslaw Klys. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'Little project to create, read, modify, split, merge PDF files on Windows, Linux and Mac.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.1'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules      = @(@{ModuleName = 'PSSharedGoods'; GUID = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'; ModuleVersion = '0.0.107'; })

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = '*'

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    # VariablesToExport = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = '*'

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = 'PDF', 'macOS', 'linux', 'windows'

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/EvotecIT/PSWritePDF/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/EvotecIT/PSWritePDF'

            # A URL to an icon representing this module.
            IconUri    = 'https://evotec.xyz/wp-content/uploads/2019/11/PSWritePDF.png'

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}