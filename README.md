# Dotfiles

Personal configuration files for terminal, editors, and tools.

## Contents

| File/Directory | Description |
|---|---|
| `.tmux.conf` | tmux configuration |
| `.zshrc` | Zsh shell configuration |
| `starship.toml` | Starship prompt theme (Catppuccin Mocha powerline) |
| `alacritty.toml` | Alacritty terminal emulator config (Windows/WSL) |
| `ghostty/config` | Ghostty terminal emulator config (Linux) |
| `VSCode/settings.json` | VS Code editor settings |
| `Zed/settings.json` | Zed editor settings |
| `solaar/rules.yaml` | Solaar rules for Logitech mouse |
| `clipCat` | Script to copy file contents to clipboard |

---

## tmux (`.tmux.conf`)

- **Plugin manager:** [TPM](https://github.com/tmux-plugins/tpm)
- **Theme:** [Dracula](https://draculatheme.com/tmux) with powerline, weather (Berlin), git status, and time
- **Keybindings:** Vim-style pane navigation (`h/j/k/l`), vi copy mode
- **Mouse support:** enabled
- **Window/pane indexing:** starts at 1, windows are automatically renumbered
- New splits open in the current pane's path
- `r` reloads the config

**Plugins:**
- `tmux-plugins/tmux-sensible`
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
- `git`, `archlinux`, `pip`, `ssh`, `tldr`, `fzf-tab`
- `zsh-syntax-highlighting` (install manually)

**Symlink:**
```bash
ln -s ~/Coding/Dotfiles/.zshrc ~/.zshrc
```

---

## Starship (`starship.toml`)

Powerline-style prompt using the **Catppuccin Mocha** palette. Segments from left to right:

`OS` → `Directory` → `Git branch/status` → `Language versions` → `Conda env` → `Time`

- Shows username always, truncates path to 3 segments
- Displays command duration (with milliseconds, notifies after 45s)
- `❯` success / `❮` vim mode indicators
- All four Catppuccin palettes defined (Mocha active)

**Symlink:**
```bash
ln -s ~/Coding/Dotfiles/starship.toml ~/.config/starship.toml
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
