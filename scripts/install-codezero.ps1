# Installs Code Zero resources into an existing QBCore txAdmin profile.
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ServerDataPath
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$serverRoot = [System.IO.Path]::GetFullPath($ServerDataPath)
$configPath = Join-Path $serverRoot 'server.cfg'
$qbCorePath = Join-Path $serverRoot 'resources/[qb]/qb-core'
$sourceResources = Join-Path $repoRoot 'resources/[codezero]'
$targetResources = Join-Path $serverRoot 'resources/[codezero]'
$sourceIcon = Join-Path $repoRoot 'assets/server-icon.png'
$targetIcon = Join-Path $serverRoot 'server-icon.png'

if (-not (Test-Path -LiteralPath $configPath -PathType Leaf)) {
    throw "No server.cfg found at '$configPath'. Pass the txAdmin profile folder containing server.cfg and resources."
}
if (-not (Test-Path -LiteralPath $qbCorePath -PathType Container)) {
    throw "QBCore was not found at '$qbCorePath'. Deploy the QBCore txAdmin recipe first."
}
if (-not (Test-Path -LiteralPath $sourceResources -PathType Container)) {
    throw "Custom resources are missing from this checkout: '$sourceResources'."
}
if (-not (Test-Path -LiteralPath $sourceIcon -PathType Leaf)) {
    throw "The supplied-logo server icon is missing: '$sourceIcon'."
}

& robocopy.exe $sourceResources $targetResources /E /NFL /NDL /NJH /NJS /NP
if ($LASTEXITCODE -ge 8) {
    throw "Robocopy failed while installing Code Zero resources (exit code $LASTEXITCODE)."
}
Copy-Item -LiteralPath $sourceIcon -Destination $targetIcon -Force

$config = Get-Content -LiteralPath $configPath -Raw -Encoding UTF8
if ($config -notmatch '(?im)^\s*ensure\s+\[codezero\]\s*$') {
    $config = $config.TrimEnd() + [Environment]::NewLine + [Environment]::NewLine + 'ensure [codezero]' + [Environment]::NewLine
}
if ($config -match '(?im)^\s*load_server_icon\s+') {
    $config = [regex]::Replace($config, '(?im)^\s*load_server_icon\s+.*$', 'load_server_icon "server-icon.png"')
} else {
    $config = $config.TrimEnd() + [Environment]::NewLine + 'load_server_icon "server-icon.png"' + [Environment]::NewLine
}
[System.IO.File]::WriteAllText($configPath, $config, [System.Text.UTF8Encoding]::new($false))

Write-Host 'Code Zero resources and logo installed.'
Write-Host "Server profile: $serverRoot"
Write-Host 'Start the server from txAdmin when ready.'
