# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A macOS LaunchAgent that watches `~/Screenshots` and renames new PNG files by replacing spaces with underscores. Two files comprise the entire project:

- `rename-screenshots.sh` — the watcher script, installed to `/usr/local/bin/`
- `com.steve.rename-screenshots.plist` — the LaunchAgent plist, installed to `~/Library/LaunchAgents/`

Requires `fswatch` (`brew install fswatch`).

## Installation & Management

```zsh
# Install
cp rename-screenshots.sh /usr/local/bin/rename-screenshots.sh
chmod +x /usr/local/bin/rename-screenshots.sh
cp com.steve.rename-screenshots.plist ~/Library/LaunchAgents/

# Load / unload
launchctl load ~/Library/LaunchAgents/com.steve.rename-screenshots.plist
launchctl unload ~/Library/LaunchAgents/com.steve.rename-screenshots.plist

# Verify running
launchctl list | grep rename-screenshots

# Live logs
tail -f /tmp/rename-screenshots.log
```

After editing the script, unload then reload the LaunchAgent to pick up changes.

## Key Details

- `fswatch` is invoked with `-0` (null-delimited output) and listens for `Created` and `Renamed` events on `~/Screenshots`.
- Only `.png` files that don't start with `.` (macOS temp files) are processed.
- Logs go to `/tmp/rename-screenshots.log` (stdout + stderr); does not persist across reboots.
- The plist uses `KeepAlive: true`, so macOS restarts the agent if it exits.
