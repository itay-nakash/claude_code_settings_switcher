#!/usr/bin/env bash
# Switch Claude Code settings: copy a profile (settings_<name>.json)
# over settings.json in the Claude settings folder.
set -eu

dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
cd "$dir"

# 1. Find the profiles: settings_<name>.json -> <name>
shopt -s nullglob
names=()
for file in settings_*.json; do
  name="${file#settings_}"
  names+=("${name%.json}")
done
if [ ${#names[@]} -eq 0 ]; then
  echo "No profiles (settings_<name>.json files) in $dir"
  exit 1
fi

# 2. Find the active profile: the one that settings.json is an exact copy of
active=""
for name in "${names[@]}"; do
  if cmp -s "settings_$name.json" settings.json; then active="$name"; fi
done
echo "Settings folder: $dir"
echo "Active profile:  ${active:-none}"

# 3. Ask which profile to use (Ctrl-D quits with no change)
PS3="Switch to (number): "
select choice in "${names[@]}"; do
  [ -n "$choice" ] && break
  echo "Type a number from the list."
done || { echo "No change."; exit 1; }

# 4. If settings.json matches no profile, keep a copy of it
if [ -z "$active" ] && [ -f settings.json ]; then
  cp settings.json settings.json.bak
  echo "settings.json matched no profile. Saved a copy as settings.json.bak."
fi

# 5. Copy the profile over settings.json
cp "settings_$choice.json" settings.json
echo "Done: settings.json is now a copy of settings_$choice.json."
echo "Restart Claude Code to apply it."
