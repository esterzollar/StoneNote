$ErrorActionPreference = "Stop"

$RepoOwner = "esterzollar"
$RepoName = "StoneNote"
$ApiUrl = "https://api.github.com/repos/$RepoOwner/$RepoName/releases/latest"

$release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "Accept" = "application/vnd.github+json" }
$asset = $release.assets | Where-Object { $_.name -match "\.exe$" } | Select-Object -First 1

if (-not $asset) {
  Write-Error "No .exe asset found in the latest release."
}

$tmpPath = Join-Path $env:TEMP $asset.name
Write-Host "Downloading $($asset.name)..."
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $tmpPath

Write-Host "Launching installer..."
Start-Process -FilePath $tmpPath
