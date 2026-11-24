$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$godotExe = 'C:\Godot\Godot_v4.7.2-stable_win64.exe'
$buildDir = Join-Path $projectRoot 'builds'
$siteDir = Join-Path $projectRoot 'web-export'
$stdoutPath = Join-Path $buildDir 'web-export.stdout.log'
$stderrPath = Join-Path $buildDir 'web-export.stderr.log'
$archivePath = Join-Path $buildDir 'index.zip'

if (-not (Test-Path -LiteralPath $godotExe)) {
    throw "Godot 4.7.2 was not found at $godotExe. Update scripts/export_web.ps1 to your Godot executable path."
}

New-Item -ItemType Directory -Force -Path $buildDir, $siteDir | Out-Null
$env:APPDATA = Join-Path $projectRoot '.godot-user-profile\Roaming'
$env:LOCALAPPDATA = Join-Path $projectRoot '.godot-user-profile\Local'
New-Item -ItemType Directory -Force -Path $env:APPDATA, $env:LOCALAPPDATA | Out-Null

$process = Start-Process -FilePath $godotExe -ArgumentList @('--headless', '--path', $projectRoot, '--export-release', 'Web', $archivePath) -WorkingDirectory $projectRoot -Wait -PassThru -WindowStyle Hidden -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath
$output = (Get-Content -LiteralPath $stdoutPath -Raw) + "`n" + (Get-Content -LiteralPath $stderrPath -Raw)
if ($process.ExitCode -ne 0 -or $output -match '(?m)(SCRIPT ERROR:|ERROR: Failed to load script|ERROR: Cannot export)') {
    throw "Godot Web export failed. Review $stdoutPath and $stderrPath"
}

$files = @(Get-ChildItem -LiteralPath $buildDir -File -Filter 'index.*' | Where-Object { $_.Name -ne 'index.zip' -and $_.Extension -ne '.import' })
if (-not ($files.Name -contains 'index.html') -or -not ($files.Name -contains 'index.wasm') -or -not ($files.Name -contains 'index.pck')) {
    throw "Godot export is incomplete. Review $stdoutPath and $stderrPath"
}

Get-ChildItem -LiteralPath $siteDir -Force | Remove-Item -Recurse -Force
foreach ($file in $files) {
    Copy-Item -LiteralPath $file.FullName -Destination $siteDir
}
Write-Output "Web build ready: $siteDir"
