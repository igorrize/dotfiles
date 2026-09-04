# Zellij Development Setup

## Installation Complete! 🎉

Your Zellij is now configured with development-friendly plugins and layouts.

## Key Features

### 1. Development Layout (`zj dev`)
- **Main tab**: Terminal + Git status + Dev info panel
- **Editor tab**: Opens Neovim in current directory
- **Server tab**: Auto-detects and starts dev server (Rails/NPM/Go)
- **Tests tab**: Runs tests (RSpec/NPM/Go)

### 2. Development Status Script
Shows:
- 📁 Current directory
- 🌿 Git branch and status (✓ clean, ✗ dirty)
- 🟢 Node.js version (if available)
- 🔵 Go version (if available)
- 🔴 Ruby version (if available)

### 3. Keybindings
- `Ctrl + o`: Session management
- `Ctrl + f`: File picker
- `Ctrl + p`: Pane mode
- `Ctrl + t`: Tab mode
- `Ctrl + s`: Scroll mode
- Standard Vim navigation in all modes

## Usage

### Start Development Session
```bash
# Using the launcher
zj dev

# Or directly with zellij
zellij --layout ~/.config/zellij/layouts/dev.kdl
```

### Quick Commands
- `Ctrl + Space` (default): Enter command mode
- `Ctrl + g`: Lock session
- `Alt + arrows`: Navigate between panes/tabs
- `Ctrl + q`: Quit Zellij

### Development Workflow
1. Launch with `zj dev`
2. Main tab shows your terminal + git info + dev status
3. Use Editor tab for coding
4. Use Server tab to start dev server
5. Use Tests tab to run tests

## Customization

### Add New Layouts
Create new `.kdl` files in `~/.config/zellij/layouts/`

### Modify Status Script
Edit `~/.config/zellij/dev-status.sh` to add more info

### Change Theme
Edit `~/.config/zellij/config.kdl` and change the theme line

## Tips
- The dev status updates automatically when you change directories
- Git status shows ✓ for clean, ✗ for dirty working directory
- All version detection is automatic - only shows what's available
- Use `Alt + 1-9` to quickly switch between tabs
- Use `Ctrl + b` then `c` to create new tabs on the fly

Enjoy your enhanced terminal experience! 🚀