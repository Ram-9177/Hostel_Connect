Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Root = (Resolve-Path "$PSScriptRoot\..").Path
Set-Location "$Root\mobile"

Write-Host "🧰 Checking Flutter..."
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw "Flutter not found. Install: https://docs.flutter.dev/get-started/install/windows"
}

Write-Host "📦 flutter pub get"
flutter pub get

# Default SDK path
$SdkDir = "$env:LOCALAPPDATA\Android\Sdk"
New-Item -ItemType Directory -Force -Path $SdkDir | Out-Null
New-Item -ItemType Directory -Force -Path "$SdkDir\cmdline-tools" | Out-Null

# Download cmdline-tools if missing
if (-not (Test-Path "$SdkDir\cmdline-tools\latest")) {
  Write-Host "⬇️  Downloading Android cmdline-tools..."
  $Tmp = New-Item -ItemType Directory -Force -Path ([System.IO.Path]::GetTempPath() + [System.Guid]::NewGuid().ToString())
  $Url = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
  $Zip = Join-Path $Tmp "cmdline-tools.zip"
  Invoke-WebRequest $Url -OutFile $Zip
  Expand-Archive $Zip -DestinationPath $Tmp -Force
  New-Item -ItemType Directory -Force -Path "$SdkDir\cmdline-tools\latest" | Out-Null
  Get-ChildItem "$Tmp\cmdline-tools" | Move-Item -Destination "$SdkDir\cmdline-tools\latest"
}

$env:ANDROID_SDK_ROOT = $SdkDir
$env:PATH = "$SdkDir\cmdline-tools\latest\bin;$SdkDir\platform-tools;$env:PATH"

Write-Host "✅ Accepting licenses..."
cmd /c "yes | sdkmanager --licenses" | Out-Null

Write-Host "📦 Installing platform tools + API 34 + emulator image..."
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" `
           "emulator" "system-images;android-34;google_apis;x86_64" | Out-Null

Write-Host "🔧 Writing local.properties..."
New-Item -ItemType Directory -Force -Path "android" | Out-Null
"sdk.dir=$SdkDir" | Out-File -Encoding ascii "android\local.properties"

Write-Host "✅ Android SDK setup complete."
