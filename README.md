# Dotfiles

## Install (Zsh + Starship)

```bash
git clone https://github.com/<your-username>/Dotfiles ~/Coding/Dotfiles
cd ~/Coding/Dotfiles
./install.sh
```

Requires `yay`. Installs: Oh My Zsh, Starship, fastfetch, zsh, fzf, zsh-syntax-highlighting, fzf-tab. Creates symlinks for `.zshrc` and `starship.toml`. Safe to re-run.

---

Personal configuration files for terminal, editors, and tools.

## Contents

| File/Directory | Description |
|---|---|
| `.tmux.conf` | tmux configuration |
| `.zshrc` | Zsh shell configuration |
| `starship/` | Starship prompt themes (`tokyo_night.toml` default, `catppuccin.toml` variant) |
| `alacritty.toml` | Alacritty terminal emulator config (Windows/WSL) |
| `ghostty/config` | Ghostty terminal emulator config (Linux) |
| `VSCode/settings.json` | VS Code editor settings |
| `Zed/settings.json` | Zed editor settings |
| `solaar/rules.yaml` | Solaar rules for Logitech mouse |
| `opencode/opencode.json` | OpenCode configuration |
| `claude/statusline-command.sh` | Claude Code custom status line script |
| `herdr/config.toml` | herdr configuration |
| `clipCat` | Script to copy file contents to clipboard |

---

## tmux (`.tmux.conf`)

- **Plugin manager:** [TPM](https://github.com/tmux-plugins/tpm)
- **Theme:** [Dracula](https://draculatheme.com/tmux) with powerline, git status, and time
- **Keybindings:** Vim-style pane navigation (`h/j/k/l`), vi copy mode
- **Mouse support:** enabled
- **Window/pane indexing:** starts at 1, windows are automatically renumbered
- New splits open in the current pane's path
- `r` reloads the config

**Plugins:**
- `dracula/tmux`

**Install TPM:**
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Then inside tmux: `prefix + I` to install plugins.

---

## Zsh (`.zshrc`)

- **Framework:** [Oh My Zsh](https://ohmyz.sh/)
- **Prompt:** [Starship](https://starship.rs/) (initialized at the end)
- **Theme:** `fishy` (Oh My Zsh, largely overridden by Starship)
- Runs `fastfetch` on shell start

**Plugins:**
- `git`, `archlinux`, `zsh-syntax-highlighting`, `pip`, `ssh`, `tldr`, `fzf-tab`
- `zsh-syntax-highlighting` and `fzf-tab` are installed manually (handled by `install.sh`)

**Symlink:**
```bash
ln -s ~/Coding/Dotfiles/.zshrc ~/.zshrc
```

---

## Starship (`starship/`)

Powerline-style prompts. Two variants live in `starship/`:

| Variant | File | Notes |
|---|---|---|
| **Tokyo Night** (default) | `starship/tokyo_night.toml` | Active prompt symlinked by `install.sh` |
| Catppuccin Mocha | `starship/catppuccin.toml` | All four Catppuccin palettes defined (Mocha active) |

Common segments, left to right: `OS` → `Directory` → `Git branch/status` → `Language versions` → `Time`

- Truncates path to 3 segments
- `❯` success / `❮` vim mode indicators

**Symlink** (the default):
```bash
ln -s ~/Coding/Dotfiles/starship/tokyo_night.toml ~/.config/starship.toml
```

`install.sh` does this for you. To install a different variant, set `STARSHIP_VARIANT` (the filename without `.toml`):
```bash
STARSHIP_VARIANT=catppuccin ./install.sh
```

---

## Ghostty (`ghostty/config`)

- **Font:** JetBrains Mono Nerd Font
- **Background:** 65% opacity with blur
- **Window size:** 130×35
- `Ctrl+Shift+W` closes the surface
- `Shift+Enter` sends escape + newline (useful for AI chat UIs)
- Copy-on-select enabled, multiple instances allowed

**Symlink:**
```bash
ln -s ~/Coding/Dotfiles/ghostty/config ~/.config/ghostty/config
```

---

## Alacritty (`alacritty.toml`)

Windows setup using WSL as the shell.

- **Font:** JetBrains Mono Nerd Font, size 13
- **Theme:** Iris (imported from `themes/`)
- **Window:** 150×30, 90% opacity, dark decorations
- **Cursor:** blinking block
- `Ctrl+Shift+T` spawns a new instance

**External dependency:** the Iris theme file is expected at `themes/themes/iris.toml` and is not included in this repository.

---

## Zed (`Zed/settings.json`)

- **Vim mode:** enabled with relative line numbers
- **Theme:** One Dark
- **Minimap:** hidden
- AI features disabled

**Symlink:**
```bash
ln -s ~/Coding/Dotfiles/Zed/settings.json ~/.config/zed/settings.json
```

---

## VS Code (`VSCode/settings.json`)

Vim extension settings with relative line numbers. Several default Vim key captures are disabled to keep native VS Code shortcuts working (`Ctrl+B`, `Ctrl+K`, `Ctrl+F`, `Ctrl+P`, `Ctrl+S`, `Ctrl+Z`).

---

## OpenCode (`opencode/opencode.json`)

Configures the [Superpowers](https://github.com/obra/superpowers) plugin and sets Bash/edit permissions to ask before running.

---

## Claude Code (`claude/statusline-command.sh`)

Custom status line script for Claude Code. Reads the session JSON on stdin and renders, separated by `|`:

- Current directory (with `$HOME` shortened to `~`)
- Git branch with a `*` dirty indicator
- Model display name
- Context window usage (`ctx:N%`)
- 5-hour rate-limit usage (`usage:N%`)

Point the `statusLine` command in your Claude Code settings at this script:
```json
{ "statusLine": { "type": "command", "command": "~/Coding/Dotfiles/claude/statusline-command.sh" } }
```

---

## herdr (`herdr/config.toml`)

Configuration for herdr:

- **Theme:** One Dark
- Onboarding disabled, agent panel scoped to all
- **Indexed keybindings:** workspaces `Ctrl+Shift`, tabs `Ctrl`, agents `Alt`

---

## Solaar (`solaar/rules.yaml`)

Rules for a Logitech mouse with a thumb wheel. Maps the wheel to browser/tab navigation:

- **Thumb wheel up (≥10):** `Ctrl+Tab` (next tab)
- **Thumb wheel down (≥10):** `Ctrl+Shift+Tab` (previous tab)

**Symlink:**
```bash
ln -s ~/Coding/Dotfiles/solaar/rules.yaml ~/.config/solaar/rules.yaml
```

---

## clipCat

A shell script that collects all files of a given extension (up to a specified depth) and copies their contents to the clipboard. Supports macOS (`pbcopy`), Wayland (`wl-copy`), and X11 (`xclip`/`xsel`).

```bash
# Copy all .py files in the current directory
./clipCat .py

# Copy all .ts files up to 3 directories deep
./clipCat .ts 3
```

**Install:**
```bash
cp clipCat ~/.local/bin/clipCat
chmod +x ~/.local/bin/clipCat
```
