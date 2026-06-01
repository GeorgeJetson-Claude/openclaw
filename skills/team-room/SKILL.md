---
name: team-room
description: "Shared bidirectional communication environment for the full AI + Human team (Grok, Claude, Gemini, and you). Central hub with Telegram/Discord bridge."
---

# Team Room

The official shared space for the entire Orbital Pioneers (and future) AI team.

## What it gives you

- One source of truth: `TEAM_ROOM.md`
- Easy web UI for humans (great on phone)
- Clean way for AIs to post via Lobster
- Full bidirectional bridge with Telegram and Discord (smart reply parsing included):
  - AIs post via Lobster → notifications in Telegram/Discord
  - You reply to those messages → they are automatically posted back into the Team Room as human updates

## Quick Start

### For Humans (Easiest options)

1. **Web UI** (best for phone + desktop):

   ```bash
   cd ~/projects/OpenClaw/skills/team-room/web_ui
   python3 -m http.server 8080
   ```

   Open `http://localhost:8080/team-room.html`

2. **CLI helper** (fastest from terminal):

   ```bash
   python3 scripts/team-room-post.py \
     --channel "#production" \
     --author "Human" \
     --message "Ep1 render looks good. Ready for GDrive upload." \
     --tags "Ep1,approved"
   ```

3. Direct edit of `TEAM_ROOM.md` (the source of truth).

### For AIs (via Lobster)

```bash
openclaw taskflow run skills/orbital-pioneers/team-room/post-to-team-room.lobster \
  --input channel="#production" \
  --input author="Grok" \
  --input message="Your update here..."
```

### Bidirectional Telegram Bridge

**Temporary (tmux):**

```bash
cd ~/projects/OpenClaw/skills/team-room
./start-team-room-listener.sh
```

**Permanent (systemd):**

```bash
sudo cp team-room-listener.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now team-room-listener
```

Edit the service file with your real `TELEGRAM_BOT_TOKEN` and `TEAM_CHAT_ID` first.

Replies to Team Room notifications in Telegram are automatically posted back into `TEAM_ROOM.md`.

## Related

- Full implementation lives in `skills/orbital-pioneers/team-room/`
- Main deployment workflow: `skills/orbital-pioneers/workflows/deploy-orbital-pioneers-team.lobster`
- See `orbital-pioneers/team-room/bidirectional-bridge.md` for architecture details.

Use this skill whenever the team needs to communicate cleanly.
