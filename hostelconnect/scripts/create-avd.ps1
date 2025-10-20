Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$SdkDir = "$env:ANDROID_SDK_ROOT"
if (-not $SdkDir) { $SdkDir = "$env:LOCALAPPDATA\Android\Sdk" }

$env:PATH = "$SdkDir\cmdline-tools\latest\bin;$SdkDir\platform-tools;$SdkDir\emulator;$env:PATH"

$AvdName = "Pixel_7_API_34"

Write-Host "🧪 Ensuring image exists..."
sdkmanager "system-images;android-34;google_apis;x86_64" | Out-Null

if ((avdmanager list avd) -match $AvdName) {
  Write-Host "✅ AVD $AvdName already exists."
} else {
  Write-Host "🆕 Creating AVD $AvdName..."
  cmd /c "echo no | avdmanager create avd -n $AvdName -k ""system-images;android-34;google_apis;x86_64"" -d pixel_7"
}

Write-Host "✅ AVD ready: $AvdName"
