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

check_requirements
install_packages
