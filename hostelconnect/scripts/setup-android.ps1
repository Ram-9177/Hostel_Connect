Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Root = (Resolve-Path "$PSScriptRoot\..").Path
Set-Location $Root

Write-Host "🎉 HostelConnect Android Setup" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Green
Write-Host ""

Write-Host "This script will set up Android development environment for HostelConnect."
Write-Host "It will:"
Write-Host "• Install Android SDK and command line tools"
Write-Host "• Create Pixel 7 API 34 emulator"
Write-Host "• Start the emulator"
Write-Host "• Run the Flutter app"
Write-Host ""

$Continue = Read-Host "Continue? (y/N)"
if ($Continue -notmatch "^[Yy]$") {
    Write-Host "Setup cancelled."
    exit 0
}

Write-Host ""
Write-Host "📱 Step 1: Installing Android SDK..." -ForegroundColor Blue
& "$PSScriptRoot\install-android-sdk.ps1"

Write-Host ""
Write-Host "🧪 Step 2: Creating AVD..." -ForegroundColor Blue
& "$PSScriptRoot\create-avd.ps1"

Write-Host ""
Write-Host "🚀 Step 3: Starting emulator..." -ForegroundColor Blue
& "$PSScriptRoot\run-emulator.ps1"

Write-Host ""
Write-Host "▶️  Step 4: Running HostelConnect app..." -ForegroundColor Blue
& "$PSScriptRoot\run-app.ps1"

Write-Host ""
Write-Host "✅ Setup complete! HostelConnect should now be running on your emulator." -ForegroundColor Green
Write-Host ""
Write-Host "Next time, you can just run:"
Write-Host ".\scripts\run-emulator.ps1"
Write-Host ".\scripts\run-app.ps1"
