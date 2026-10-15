# claude-settings-switcher

A small script that switches Claude Code between saved settings files.

Claude Code reads its user settings from `~/.claude/settings.json`.
A **profile** is a copy of that file with the name `settings_<name>.json`, in the same folder.
The script shows your profiles, asks which one to use, and copies it over `settings.json`.

## Requirements

- macOS or Linux, with bash 3.2 or later. Both include bash.
- Claude Code, with its settings folder at `~/.claude`.
  If you set `CLAUDE_CONFIG_DIR`, the script uses that folder.

## Setup

1. Get the script:

   ```sh
   git clone <repo-url>
   cd claude-settings-switcher
   ```

2. Give the script the execute permission, so that you can run it:

   ```sh
   chmod +x switch-settings.sh
   ```

   The script needs no other permission and no `sudo`.
   It reads and writes files only in your settings folder.

3. Make one profile for each set of settings that you use. For example:

   ```sh
   cp ~/.claude/settings.json ~/.claude/settings_antropic.json
   cp ~/.claude/settings.json ~/.claude/settings_curvebender.json
   ```

   Then edit each profile.

## Usage

```console
$ ./switch-settings.sh
Settings folder: /Users/you/.claude
Active profile:  work
1) personal
2) work
Switch to (number): 1
Done: settings.json is now a copy of settings_personal.json.
Restart Claude Code to apply it.
```

After a switch, restart Claude Code.

If `settings.json` matches no profile, the script first saves it as `settings.json.bak`.
This keeps changes that are in no profile, for example a setting that Claude Code wrote.

To run the script from any folder, add an alias to `~/.zshrc` (or `~/.bashrc`):

```sh
alias claude-switch="$HOME/path/to/claude-settings-switcher/switch-settings.sh"
```
