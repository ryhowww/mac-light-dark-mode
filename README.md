# Light Dark Mode

A tiny native macOS menu-bar app that toggles the system between Light and Dark
appearance with a single click. No Dock icon, no window, just an icon in the menu
bar that flips your whole Mac between light and dark.

## Why

macOS can switch appearance on its own, but every built-in path takes more than one
step: open Control Center, click into the Display section, then choose Dark Mode, or
set up a keyboard shortcut through the Shortcuts app. This is one click from the menu
bar, and the icon shows you which mode you're currently in.

## What it does

- Lives only in the menu bar (no Dock icon, no window).
- Left-click the icon toggles the system between Light and Dark.
- Right-click opens a small menu: Toggle Light / Dark, and Quit.
- The icon is a half-filled circle that flips sides with the current mode, so you
  can see at a glance which appearance is active. (It deliberately avoids the
  crescent-moon symbol, which looks identical to the macOS Focus indicator.)
- Stays in sync if you change appearance some other way (Control Center, Settings).

## Requirements

- macOS 13 or later.
- Xcode Command Line Tools, for `swiftc` (`xcode-select --install`).

## Build and install

    ./build.sh

That compiles the app into `~/Applications/Light Dark Mode.app`. Open it from there.

## First run

Left-click the menu-bar icon once and approve the prompt asking to control System
Events. That permission is what lets the app flip the appearance.

Because the build is ad-hoc signed, the signature changes every time you rebuild,
and macOS asks for that permission again after each `./build.sh`. If the toggle
ever silently stops working (the prompt was dismissed or denied), reset it with:

    tccutil reset AppleEvents com.ryhowww.lightdarkmode

then relaunch the app and approve the prompt on the next click.

## Start it on login (optional)

Add the app under System Settings > General > Login Items so it launches on boot.

## A note on signing

The build is ad-hoc signed (it doesn't use a paid Apple Developer certificate), so
the first time you open it macOS may warn that it's from an unidentified developer.
Right-click the app and choose Open to get past that once. After that it runs
normally. Since you're building it yourself from this source, you can see exactly
what it does.

## How it works

It's a single Swift file using `NSStatusItem` for the menu-bar item. The actual
toggle is one line of AppleScript run through `NSAppleScript`:

    tell application "System Events" to tell appearance preferences to set dark mode to not dark mode

Edit `src/main.swift` and re-run `./build.sh` to change anything.

## License

MIT. See [LICENSE](LICENSE).
