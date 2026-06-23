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

# Ad-hoc signature so the one-time Automation permission stays tied to a stable identity.
codesign --force --sign - "$APP"

echo "Built $APP"
