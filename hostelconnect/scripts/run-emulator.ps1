Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$SdkDir = "$env:ANDROID_SDK_ROOT"
if (-not $SdkDir) { $SdkDir = "$env:LOCALAPPDATA\Android\Sdk" }

$env:PATH = "$SdkDir\emulator;$SdkDir\platform-tools;$env:PATH"

$AvdName = if ($args.Count -gt 0) { $args[0] } else { "Pixel_7_API_34" }

Write-Host "🚀 Starting emulator: $AvdName"
Start-Process -FilePath "emulator" -ArgumentList "-avd `"$AvdName`" -no-snapshot -netdelay none -netspeed full"

Write-Host "⏳ Waiting for device..."
& adb wait-for-device
& adb devices

Write-Host "✅ Emulator ready."
