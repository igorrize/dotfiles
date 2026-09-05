#!/usr/bin/env bash
# Symlinks configs into ~/.config and clones the neovim config repo.
# Idempotent. Used both by DevPod (--dotfiles) and manually on any machine.
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.config"

for name in zellij fish kitty git; do
  src="$DOTFILES_DIR/config/$name"
  [ -e "$src" ] || continue
  target="$HOME/.config/$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "${target}.pre-dotfiles.$(date +%s)"   # back up a real dir once
  fi
  ln -sfn "$src" "$target"
  echo "linked ~/.config/$name -> $src"
done

# expose the zj launcher on PATH (~/.local/bin is added to PATH in config.fish)
mkdir -p "$HOME/.local/bin"
ln -sfn "$HOME/.config/zellij/zj" "$HOME/.local/bin/zj"
echo "linked ~/.local/bin/zj -> ~/.config/zellij/zj"

# neovim config lives in its own repo (private -> needs auth or SSH-agent forwarding)
if [ ! -d "$HOME/.config/nvim/.git" ]; then
  rm -rf "$HOME/.config/nvim"
  git clone --depth 1 https://github.com/igorrize/nvim.git "$HOME/.config/nvim" \
    || git clone --depth 1 git@github.com:igorrize/nvim.git "$HOME/.config/nvim" \
    || echo "WARN: could not clone nvim config (make it public, or forward your ssh-agent)"
fi

echo "dotfiles install done"
