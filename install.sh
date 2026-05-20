#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}[✓]${NC} $1"; }
info() { echo -e "    [→] $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
fail() { echo -e "${RED}[✗]${NC} $1"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

check_requirements() {
    if ! command -v yay &>/dev/null; then
        fail "yay not found. Install it from: https://github.com/Jguer/yay"
    fi
    ok "yay found"
}

check_requirements
