#!/usr/bin/env bash
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { printf "${GREEN}[✓]${NC} %s\n" "$1"; }
info() { printf "    [→] %s\n" "$1"; }
warn() { printf "${YELLOW}[!]${NC} %s\n" "$1"; }
fail() { printf "${RED}[✗]${NC} %s\n" "$1"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

check_requirements() {
    if ! command -v yay &>/dev/null; then
        fail "yay not found. Install it from: https://github.com/Jguer/yay"
    fi
    ok "yay found"
    if ! command -v curl &>/dev/null; then
        fail "curl not found. Install it with: yay -S curl"
    fi
    ok "curl found"
}

install_packages() {
    local packages=(starship fastfetch zsh fzf)
    for pkg in "${packages[@]}"; do
        if pacman -Qi "$pkg" &>/dev/null; then
            ok "$pkg already installed, skipping"
        else
            info "Installing $pkg via yay..."
            yay -S --noconfirm "$pkg"
            ok "$pkg installed"
        fi
    done
}

install_omz() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        ok "Oh My Zsh already installed, skipping"
        return
    fi
    info "Installing Oh My Zsh..."
    local installer
    installer="$(mktemp)"
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "$installer"
    RUNZSH=no CHSH=no sh "$installer"
    rm -f "$installer"
    ok "Oh My Zsh installed"
}

install_omz_plugins() {
    local custom_plugins="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

    if [[ ! -d "$custom_plugins/zsh-syntax-highlighting" ]]; then
        info "Cloning zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            "$custom_plugins/zsh-syntax-highlighting"
        ok "zsh-syntax-highlighting installed"
    else
        ok "zsh-syntax-highlighting already installed, skipping"
    fi

    if [[ ! -d "$custom_plugins/fzf-tab" ]]; then
        info "Cloning fzf-tab..."
        git clone https://github.com/Aloxaf/fzf-tab "$custom_plugins/fzf-tab"
        ok "fzf-tab installed"
    else
        ok "fzf-tab already installed, skipping"
    fi
}

_symlink() {
    local src="$1"
    local dest="$2"

    if [[ -L "$dest" ]]; then
        if [[ "$(readlink "$dest")" == "$src" ]]; then
            ok "Symlink already correct: $dest"
            return
        fi
        warn "Replacing existing symlink: $dest → $(readlink "$dest")"
        rm "$dest"
    elif [[ -e "$dest" ]]; then
        warn "$dest exists — backed up to $dest.bak"
        mv "$dest" "$dest.bak"
    fi

    ln -s "$src" "$dest"
    ok "Symlink created: $dest → $src"
}

install_symlinks() {
    mkdir -p "$HOME/.config"
    _symlink "$SCRIPT_DIR/.zshrc"        "$HOME/.zshrc"
    _symlink "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
}

check_requirements
install_packages
install_omz
install_omz_plugins
install_symlinks
