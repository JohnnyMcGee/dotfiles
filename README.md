# dotfiles

Shared configuration for my Linux and macOS machines. Run `./install.sh` after cloning.

## Why it's built this way

- **GNU Stow, one folder per tool.** Each top-level folder mirrors `$HOME`, and Stow symlinks it into place. Edits in the repo take effect immediately, and no templating engine is needed for a config set this small.
- **`--no-folding`.** Without it, Stow symlinks whole directories (e.g. `~/.config/tmux` → repo), so any file a machine writes there silently lands in the repo. With it, only the tracked files are links.
- **`local.conf` for machine-specific settings.** The shared config ends with `source-file -q ~/.config/tmux/local.conf`. Anything tied to one machine (paths into other repos, a different prefix) goes there. It is gitignored, and `-q` means machines without one don't error.
- **XDG paths.** tmux has read `~/.config/tmux/tmux.conf` since 3.1. If an old `~/.tmux.conf` exists, remove it: Stow won't link over it, and tmux would still read it.

## macOS gotcha

Ctrl+Space is the tmux prefix, but macOS binds it to "Select the previous input source". Disable that in System Settings → Keyboard → Keyboard Shortcuts → Input Sources, or the prefix never reaches tmux.
