Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-Location (Join-Path $PSScriptRoot "..\mobile")

Write-Host "📱 Devices:"
flutter devices

Write-Host "▶️  Running app..."
flutter run
