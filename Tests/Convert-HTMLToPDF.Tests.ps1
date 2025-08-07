Describe 'Convert-HTMLToPDF' {
    BeforeAll {
        $script:outputDir = Join-Path $PSScriptRoot 'Output' 'ConvertHTML'
        if (Test-Path $script:outputDir) {
            Remove-Item -LiteralPath $script:outputDir -Recurse -Force
        }
        New-Item -Path $script:outputDir -ItemType Directory | Out-Null
    }

    It 'converts HTML string to PDF and outputs file path' {
        $file = Join-Path $script:outputDir 'converted.pdf'
        $result = Convert-HTMLToPDF -Content '<html><body>Test</body></html>' -OutputFilePath $file
        Test-Path $file | Should -BeTrue
        $result | Should -Be $file
    }

    It 'overwrites existing file only when Force is used' {
        $file = Join-Path $script:outputDir 'force.pdf'
        Convert-HTMLToPDF -Content '<html><body>First</body></html>' -OutputFilePath $file | Out-Null
        $timestamp = (Get-Item $file).LastWriteTime
        Start-Sleep -Seconds 1
        Convert-HTMLToPDF -Content '<html><body>Second</body></html>' -OutputFilePath $file | Out-Null
        (Get-Item $file).LastWriteTime | Should -Be $timestamp
        Convert-HTMLToPDF -Content '<html><body>Second</body></html>' -OutputFilePath $file -Force | Out-Null
        (Get-Item $file).LastWriteTime | Should -Not -Be $timestamp
    }

    It 'converts HTML from a URI' {
        $file = Join-Path $script:outputDir 'uri.pdf'
        $result = Convert-HTMLToPDF -Uri 'https://example.com/' -OutputFilePath $file -Confirm:$false
        Test-Path $file | Should -BeTrue
        $result | Should -Be $file
    }

    It 'resolves external assets with BaseUri and CssFilePath' {
        $assetDir = Join-Path $PSScriptRoot 'Input' 'Assets'
        if (Test-Path $assetDir) { Remove-Item $assetDir -Recurse -Force }
        New-Item -Path $assetDir -ItemType Directory | Out-Null
        Copy-Item -Path (Join-Path $PSScriptRoot '..' 'Example' 'Example09.Images' 'Evotec-Logo-600x190.png') -Destination (Join-Path $assetDir 'logo.png')
        $htmlPath = Join-Path $assetDir 'index.html'
        '<html><head><title>Assets</title></head><body><h1>Hello</h1><img src="logo.png" /></body></html>' | Set-Content -Path $htmlPath
        $cssPath = Join-Path $assetDir 'style.css'
        'h1{color:blue;}' | Set-Content -Path $cssPath
        $file = Join-Path $script:outputDir 'assets.pdf'
        Convert-HTMLToPDF -FilePath $htmlPath -BaseUri $assetDir -CssFilePath $cssPath -OutputFilePath $file -Confirm:$false | Out-Null
        Test-Path $file | Should -BeTrue
        Remove-Item $assetDir -Recurse -Force
    }

    AfterAll {
        Remove-Item -LiteralPath $script:outputDir -Recurse -Force
    }
}
