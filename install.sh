#!/usr/bin/env bash
# Miku OS — dotfiles installer
# Symlinks theming files into place. Backs up existing files first.
set -e
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.miku-os-backup-$(date +%s)"
echo "Backing up existing dotfiles to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
for file in .zshrc .bashrc .zprofile; do
  if [ -f "$HOME/$file" ]; then
    cp "$HOME/$file" "$BACKUP_DIR/"
  fi
  ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
  echo "Linked $file"
done
mkdir -p "$HOME/.local/bin" "$HOME/.config"
cp "$DOTFILES_DIR/miku_speak.sh" "$HOME/.local/bin/miku_speak.sh"
chmod +x "$HOME/.local/bin/miku_speak.sh"
cp "$DOTFILES_DIR/miku_combined.txt" "$HOME/.config/miku_combined.txt"
cp "$DOTFILES_DIR/.miku_terminal.sh" "$HOME/.miku_terminal.sh"
echo ""
echo "Done. Restart your shell or run: source ~/.zshrc"
echo ""
echo "Optional: set your own name for the greeting by adding to your shell config:"
echo '  export MIKU_USER_NAME_JP="あなたの名前"'
echo '  export MIKU_USER_NAME_EN="YourName"'
echo ""
echo "Requires: mpv (audio playback), lolcat (banner colors), and optionally"
echo "VOICEVOX running locally (http://localhost:50021) for voice greetings."
echo "See: https://voicevox.hiroshiba.jp/"
