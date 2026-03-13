# dotfiles

Personal configuration files for Claude Code, synchronized across machines via symlinks.

## Before you start

Adjust these values to match your setup before running any command:

- **Repo path:** this guide assumes `~/Github/dotfiles`. Change it if your repo lives elsewhere (e.g. `~/code/dotfiles`, `~/dotfiles`).
- **GitHub username:** replace `TU_USUARIO` in the clone URL with your actual username.
- **File names:** `statusline.sh` and any other files must match the exact names inside `~/.claude/`. If yours are named differently, update the `files` array in `install.sh`.
- **Folder names:** same applies to `plugins/` and `skills/`. If you don't have one of them, remove it from the `dirs` array in `install.sh`.
- **Linux home path:** symlinks will point to `/home/USER/Github/dotfiles/...`. On macOS they point to `/Users/USER/Github/dotfiles/...`. Both work independently.

## What's synced

```
claude/
  CLAUDE.md        # Global instructions for all projects
  settings.json    # Preferences, model, permissions
  statusline.sh    # Statusline command
  plugins/         # Installed plugin configurations
  skills/          # Custom skills
```

**Not synced:** `.credentials.json`, `settings.local.json`, `projects/`. Re-authenticate on each machine with `claude login`.

## Setup

### First machine (already configured)

```bash
./install.sh
git add . && git commit -m "update claude config" && git push
```

### New machine

```bash
git clone https://github.com/TU_USUARIO/dotfiles.git ~/Github/dotfiles
~/Github/dotfiles/install.sh
```

The script symlinks everything from `~/Github/dotfiles/claude/` into `~/.claude/`. Existing files are backed up with a `.bak` extension before being replaced.

Verify symlinks:

```bash
ls -la ~/.claude/CLAUDE.md ~/.claude/settings.json ~/.claude/plugins ~/.claude/skills
```

Each line should show `→ /home/USER/Github/dotfiles/claude/...`.

## Daily workflow

**Push changes:**
```bash
cd ~/Github/dotfiles
git add . && git commit -m "update claude config" && git push
```

**Pull changes on another machine:**
```bash
cd ~/Github/dotfiles && git pull
```

No need to re-run `install.sh`. Symlinks are permanent.

## Adding more folders to sync

Add the folder name to the `dirs` array in `install.sh`:

```bash
dirs=(plugins skills agents commands hooks)
```

Then copy the folder to the repo and push:

```bash
cp -r ~/.claude/NEW_FOLDER ~/Github/dotfiles/claude/NEW_FOLDER
git add . && git commit -m "add NEW_FOLDER to sync" && git push
```
