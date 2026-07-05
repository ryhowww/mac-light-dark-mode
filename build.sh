#!/bin/bash
# Builds "Light Dark Mode.app" into ~/Applications. Re-run after editing src/main.swift.
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
APP="$HOME/Applications/Light Dark Mode.app"
MACOS="$APP/Contents/MacOS"

rm -rf "$APP"
mkdir -p "$MACOS"
cp "$DIR/src/Info.plist" "$APP/Contents/Info.plist"

swiftc -O \
    -framework Cocoa \
    -o "$MACOS/LightDarkMode" \
    "$DIR/src/main.swift"

# Ad-hoc signature. NOTE: this changes on every rebuild, so macOS re-asks for the
# Automation permission after each build — click Allow on the prompt at first toggle.
# If the toggle silently stops working (prompt was dismissed/denied), reset with:
#   tccutil reset AppleEvents com.ryhowww.lightdarkmode
codesign --force --sign - "$APP"

echo "Built $APP"
