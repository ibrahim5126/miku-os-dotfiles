# Miku OS

A fully custom-themed Linux terminal environment — teal/Hatsune Miku aesthetic, Japanese voice greetings, ASCII startup banner, and shell utility functions layered on top of zsh/bash.

## What's included

- **Teal-themed shell prompt and startup banner** (zsh + bash)
- **ASCII art greeting** on new terminal sessions
- **Japanese voice greetings** via [VOICEVOX](https://voicevox.hiroshiba.jp/) (local, free TTS engine — Zundamon voice)
- **`alert` function** — wraps any command, announces completion or failure by voice with elapsed time
- **Command-not-found handler** with a themed error response
- **Configurable user name** — greetings use your name via environment variables, not hardcoded

## Requirements

- zsh (with [oh-my-zsh](https://ohmyz.sh/) recommended) and/or bash
- [`mpv`](https://mpv.io/) — for playing synthesized voice audio
- [VOICEVOX](https://voicevox.hiroshiba.jp/) — running locally on `localhost:50021` (voice greetings fail silently if not running, so this is optional)

## Install

```bash
git clone https://github.com/ibrahim5126/miku-os-dotfiles.git
cd miku-os-dotfiles
./install.sh
```

This backs up your existing `.zshrc` / `.bashrc` / `.zprofile` before symlinking the new ones.

## Customize your name

By default, the greeting uses a placeholder name. Set your own before sourcing your shell config:

```bash
export MIKU_USER_NAME_JP="あなたの名前"
export MIKU_USER_NAME_EN="YourName"
```

Add these lines to your `.zshrc` or `.bashrc` above the Miku section to make them persistent.

## Why

Built while learning daily Linux usage from scratch — real cross-shell (bash/zsh) config conflicts, dependency chains, and package build issues were debugged by hand to get this working, no tutorial followed start to finish.

## Status

Actively maintained, still evolving.
