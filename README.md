# dotfiles

Terminal configs for zellij, fish, kitty, git. Neovim config lives in its own
repo ([igorrize/nvim](https://github.com/igorrize/nvim)) and is cloned by the
installer.

## Use

```bash
git clone https://github.com/igorrize/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` symlinks `config/*` into `~/.config/*` (backing up any existing real
dir once as `*.pre-dotfiles.<ts>`) and clones the neovim config.

## With DevPod

Applied automatically to every workspace:

```bash
devpod up <git-url> --ide none --dotfiles https://github.com/igorrize/dotfiles
```

The devcontainer's `setup.sh` installs the binaries (nvim, zellij, lazygit, fish,
claude, pi); this repo provides their configs.
