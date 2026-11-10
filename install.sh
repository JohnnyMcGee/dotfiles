#!/usr/bin/env bash
# Install dependencies and symlink every package folder into $HOME. Safe to re-run.
set -euo pipefail

cd "$(dirname "$0")"

PACKAGES=(tmux)
DEPS=(stow tmux)

install_deps() {
  local missing=()
  for dep in "${DEPS[@]}"; do
    command -v "$dep" >/dev/null 2>&1 || missing+=("$dep")
  done
  [ ${#missing[@]} -eq 0 ] && return

  case "$(uname -s)" in
    Darwin)
      command -v brew >/dev/null 2>&1 || { echo "Install Homebrew first: https://brew.sh" >&2; exit 1; }
      brew install "${missing[@]}"
      ;;
    Linux)
      sudo apt-get update
      sudo apt-get install -y "${missing[@]}"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
}

install_deps

# --no-folding keeps target dirs real so untracked files (e.g. local.conf) never land in the repo
stow --no-folding --restow --target="$HOME" "${PACKAGES[@]}"

echo "Linked: ${PACKAGES[*]}"
