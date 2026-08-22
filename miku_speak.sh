#!/usr/bin/env bash

# Block execution inside VS Code integrated terminal
if [ "$TERM_PROGRAM" = "vscode" ] || \
   [ -n "$VSCODE_INJECTION" ] || \
   [ -n "$VSCODE_PID" ] || \
   [ -n "$VSCODE_IPC_HOOK_CLI" ] || \
   [ -n "$VSCODE_SHELL_INTEGRATION" ] || \
   pstree -s $$ 2>/dev/null | grep -qi "code"; then
  exit 0
fi

# Voicevox character ID (3 = Zundamon sweet/anime voice)
SPEAKER_ID=3
HOST="http://localhost:50021"
TEXT="$1"

if [ -z "$TEXT" ]; then
  exit 0
fi

TMP_AUDIO="/tmp/voicevox_${RANDOM}.wav"

# 1. Create Audio Query
QUERY=$(curl -s -X POST "${HOST}/audio_query?speaker=${SPEAKER_ID}" \
  --get \
  --data-urlencode "text=${TEXT}")

# Exit gracefully if engine is unreachable
if [ -z "$QUERY" ] || echo "$QUERY" | grep -q "detail"; then
  exit 0
fi

# 2. Synthesize to WAV and play in the background
curl -s -H "Content-Type: application/json" \
  -X POST -d "$QUERY" \
  "${HOST}/synthesis?speaker=${SPEAKER_ID}" \
  -o "$TMP_AUDIO"

if [ -f "$TMP_AUDIO" ]; then
  mpv --no-video --really-quiet "$TMP_AUDIO" >/dev/null 2>&1 && rm -f "$TMP_AUDIO" &
fi
