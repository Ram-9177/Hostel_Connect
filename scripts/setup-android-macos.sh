#!/usr/bin/env bash
set -euo pipefail

# Android + Flutter Android prerequisites setup for macOS (Apple Silicon/Intel)
# - Installs: Homebrew (if missing), JDK 17 (Temurin), Android Studio, platform-tools, cmdline-tools
# - Configures: ANDROID_HOME, JAVA_HOME, PATH
# - Installs SDK packages: build-tools;34.0.0, platforms;android-34, platform-tools, emulator, system image (arm64)
# - Accepts licenses and creates a default AVD (Pixel_7_API_34)
#
# Usage:
#   chmod +x scripts/setup-android-macos.sh
#   ./scripts/setup-android-macos.sh

cyan() { printf "\033[36m%s\033[0m\n" "$*"; }
green() { printf "\033[32m%s\033[0m\n" "$*"; }
red() { printf "\033[31m%s\033[0m\n" "$*"; }

BREW_PREFIX="$(/usr/bin/which brew >/dev/null 2>&1 && brew --prefix || true)"

cyan "[1/8] Checking Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv || true)"
fi

cyan "[2/8] Installing Java 17 (Temurin)"
brew install --cask temurin@17 || true

cyan "[3/8] Installing Android Studio + Platform Tools + Commandline Tools"
brew install --cask android-studio || true
brew install --cask android-platform-tools || true
brew install --cask android-commandlinetools || true

# Default SDK path
SDK_ROOT="$HOME/Library/Android/sdk"
mkdir -p "$SDK_ROOT"

cyan "[4/8] Configuring environment variables (ANDROID_HOME, JAVA_HOME, PATH)"
SHELL_RC="${SHELL##*/}"
RC_FILE="$HOME/.zshrc"
if [ "$SHELL_RC" = "bash" ]; then RC_FILE="$HOME/.bashrc"; fi

# Detect JAVA_HOME from Temurin 17
JAVA_HOME_PATH=$(/usr/libexec/java_home -v 17 2>/dev/null || true)

LINE_ANDROID_HOME="export ANDROID_HOME=\"$SDK_ROOT\""
LINE_ANDROID_SDK_ROOT="export ANDROID_SDK_ROOT=\"$SDK_ROOT\""
LINE_JAVA_HOME="export JAVA_HOME=\"${JAVA_HOME_PATH:-/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home}\""
LINE_PATH1='export PATH="$ANDROID_HOME/platform-tools:$PATH"'
LINE_PATH2='export PATH="$ANDROID_HOME/emulator:$PATH"'
LINE_PATH3='export PATH="$ANDROID_HOME/tools/bin:$PATH"'
LINE_PATH4='export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"'

ensure_line() { grep -qF "$1" "$RC_FILE" 2>/dev/null || echo "$1" >> "$RC_FILE"; }
ensure_line "$LINE_ANDROID_HOME"
ensure_line "$LINE_ANDROID_SDK_ROOT"
ensure_line "$LINE_JAVA_HOME"
ensure_line "$LINE_PATH1"
ensure_line "$LINE_PATH2"
ensure_line "$LINE_PATH3"
ensure_line "$LINE_PATH4"

# Apply to current shell
# shellcheck disable=SC1090
source "$RC_FILE" || true

cyan "[5/8] Installing SDK packages via sdkmanager"
SDKMANAGER="sdkmanager"
if ! command -v sdkmanager >/dev/null 2>&1; then
  # Try common locations from cask
  if [ -x "/usr/local/share/android-commandlinetools/bin/sdkmanager" ]; then
    SDKMANAGER="/usr/local/share/android-commandlinetools/bin/sdkmanager"
  elif [ -x "/opt/homebrew/share/android-commandlinetools/bin/sdkmanager" ]; then
    SDKMANAGER="/opt/homebrew/share/android-commandlinetools/bin/sdkmanager"
  elif [ -x "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
    SDKMANAGER="$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"
  fi
fi

if ! command -v "$SDKMANAGER" >/dev/null 2>&1; then
  red "Could not find sdkmanager. Open Android Studio once, install SDK + Command-line Tools, then re-run this script."
  exit 1
fi

# Ensure cmdline-tools/latest is present (some installs use 'bin' directly)
mkdir -p "$ANDROID_HOME/cmdline-tools/latest"
if [ ! -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]; then
  if [ -d "/usr/local/share/android-commandlinetools" ]; then
    cp -R "/usr/local/share/android-commandlinetools" "$ANDROID_HOME/cmdline-tools/latest"
  elif [ -d "/opt/homebrew/share/android-commandlinetools" ]; then
    cp -R "/opt/homebrew/share/android-commandlinetools" "$ANDROID_HOME/cmdline-tools/latest"
  fi
fi

"$SDKMANAGER" --sdk_root="$ANDROID_HOME" --install \
  "platform-tools" \
  "emulator" \
  "build-tools;34.0.0" \
  "platforms;android-34" \
  "cmdline-tools;latest" \
  "sources;android-34" || true

cyan "[6/8] Accepting Android licenses"
printf 'y\n' | "$SDKMANAGER" --sdk_root="$ANDROID_HOME" --licenses >/dev/null || true

cyan "[7/8] Creating an ARM64 AVD (Pixel_7_API_34)"
SYSTEM_IMAGE="system-images;android-34;google_apis;arm64-v8a"
"$SDKMANAGER" --sdk_root="$ANDROID_HOME" --install "$SYSTEM_IMAGE" || true
AVDMANAGER="$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager"
if [ -x "$AVDMANAGER" ]; then
  if ! "$AVDMANAGER" list avd | grep -q "Pixel_7_API_34"; then
    echo no | "$AVDMANAGER" create avd -n Pixel_7_API_34 -k "$SYSTEM_IMAGE" -d pixel_7 || true
  fi
fi

cyan "[8/8] Done. Next steps:"
echo "- Open a new terminal or run: source $RC_FILE"
echo "- Verify: flutter doctor -v"
echo "- Start emulator: emulator -avd Pixel_7_API_34 &"
echo "- Run app from repo root: (cd hostelconnect/mobile && flutter pub get && flutter run)"

green "Android toolchain setup completed."
