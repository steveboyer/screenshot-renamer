# rename-screenshots

A minimal macOS LaunchAgent that watches `~/Screenshots` and automatically renames new PNG files by replacing spaces with underscores.

**Before:** `Screenshot 2026-03-22 at 10.00.14 AM.png`
**After:** `Screenshot_2026-03-22_at_10.00.14_AM.png`

## Requirements

- macOS
- [fswatch](https://github.com/emcrisostomo/fswatch) (`brew install fswatch`)

## Installation

```bash
# Install the script
cp rename-screenshots.sh /usr/local/bin/rename-screenshots.sh
chmod +x /usr/local/bin/rename-screenshots.sh

# Install and load the LaunchAgent
cp com.steve.rename-screenshots.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.steve.rename-screenshots.plist
```

## Verification

```bash
# Confirm the agent is running
launchctl list | grep rename-screenshots

# Watch live logs
tail -f /tmp/rename-screenshots.log
```

## Management

```bash
# Stop
launchctl unload ~/Library/LaunchAgents/com.steve.rename-screenshots.plist

# Start
launchctl load ~/Library/LaunchAgents/com.steve.rename-screenshots.plist

# Restart after editing the script
launchctl unload ~/Library/LaunchAgents/com.steve.rename-screenshots.plist
launchctl load ~/Library/LaunchAgents/com.steve.rename-screenshots.plist
```

## How It Works

`fswatch` monitors `~/Screenshots` for `Created` events. When a new `.png` file appears, the script renames it in-place with spaces replaced by underscores. Non-PNG files and already-clean filenames are left untouched.

The LaunchAgent starts at login and is kept alive by macOS automatically if it ever exits.

## Logs

Output and errors are written to `/tmp/rename-screenshots.log`. This file does not persist across reboots, which is fine for a simple background utility.
