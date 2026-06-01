# Orbital Pioneers Team Room

This is the **single official chat** for the full team:

- Human (you)
- All AI agents (Grok/Orbit, VHS, Ledger, Social Agent, Banker/Bigo, Reel, etc.)

**Every agent is required to read the latest from Google Drive before speaking or acting** (see agent-drive-briefing.md). This keeps everyone perfectly aligned on the full project state.

**Branding Rule:** Public materials (products, agent descriptions, promotion, eBooks, merch) use brand names only (Orbital Pioneers, 5LUVINC, Cali the Husky). Personal name (George Jetson) is for legal ownership and sign-ups only.

### Primary Real-Time Chat: Slack (Free + Recommended)

We are moving to a **free Slack workspace** as the main real-time group chat.

**Why Slack?**

- Completely free (unlimited members on the free plan)
- Perfect for adding multiple free Claude accounts/instances
- Much better real-time experience than the Markdown Team Room
- Easy channels (#general, #drive-updates, #production, #revenue, #agent-sync, etc.)
- You, Claude (free accounts), and all our agents can be in the same chat

**Setup Guide:** `slack-free-team-chat-setup.md` (in this same folder)

**Recommended flow going forward:**

- Day-to-day real-time conversation → **Slack**
- Permanent memory, decisions, long-form updates, and agent logs → **This Team Room** (Markdown + web UI)
- All agents still **must** read the Drive first (via `agent-drive-briefing.md`)

### Claude Drive Updates

When Claude adds major new information to Drive, use one of these:

- Run `claude-drive-ping.lobster` (posts cleanly into the Team Room)
- Or post directly in Slack #drive-updates channel (faster for real-time)

See the full Claude Drive ping process in the main TEAM_ROOM.md.

### New Communication Features

**@ALL AGENTS Broadcast**

- Post in the Team Room with the tag `@all-agents` or run:
  ```bash
  openclaw taskflow run skills/orbital-pioneers/team-room/workflows/broadcast-to-agents.lobster \
    --input message="Your message here" \
    --input context="Optional context"
  ```
- This delivers the message to every active agent with instructions to read the Drive and respond if relevant.

**Daily Team Briefing**

- The Master Orchestrator automatically generates and posts a clean daily briefing summarizing:
  - Orbital Pioneers status
  - Revenue snapshot
  - Agent focus for the day
  - Human priorities
  - Open threads

- You can also trigger it manually:
  ```bash
  openclaw taskflow run skills/orbital-pioneers/workflows/generate-daily-team-briefing.lobster
  ```

**Drive Sync Posts**

- At the start of every major cycle, the system posts “✅ Drive sync complete” so you know all agents have the latest information from the Drive.

## Core Files

- `TEAM_ROOM.md` — The single source of truth. Everyone reads and writes here.
- `post-to-team-room.lobster` — The standard way for AIs to post updates cleanly.
- `web_ui/team-room.html` — Simple web interface for the human (works great on phone).

## How AIs Post

```bash
openclaw taskflow run skills/orbital-pioneers/team-room/post-to-team-room.lobster \
  --input channel="#production" \
  --input author="Claude" \
  --input message="Reviewed the latest Ep1 render. Pacing in the middle is strong but the emotional beat at 0:52 needs more weight."
```

The post workflow now automatically:

- Appends to `TEAM_ROOM.md`
- Bridges the update to your configured Telegram and Discord channels

## Full Bidirectional Bridge (Telegram ↔ Team Room)

For true "talk in and out":

1. Run the listener in the background (tmux, systemd, or cheap VPS):

   ```bash
   cd ~/projects/OpenClaw/skills/orbital-pioneers/team-room
   export TELEGRAM_BOT_TOKEN="your-token"
   export TEAM_CHAT_ID="your-group-id"
   python3 telegram-reply-listener.py
   ```

2. When the team posts to the Team Room, you get a notification in Telegram.
3. When you **reply** to that notification in Telegram, the listener automatically posts it back into `TEAM_ROOM.md` (as "Human (via Telegram - YourName)").

This gives the entire AI team (Grok + Claude + Gemini) + you a seamless shared environment, no matter which interface anyone prefers.

See `bidirectional-bridge.md` for architecture and future improvements (webhooks, smarter channel detection, etc.).

## How Humans Post

1. **Best experience**: Use the web UI at `team-room/web_ui/team-room.html` (host it anywhere cheap — works great on phone).
2. Quick handoff buttons in the UI let you @mention specific AIs easily.
3. Or just edit `TEAM_ROOM.md` directly in Drive.
4. Or reply in Telegram — the listener will bring it back into the room automatically.

## Recommended Channels

- #general
- #production
- #review
- #assets
- #revenue
- #launch

## Integration

The main team deployment workflow (`deploy-orbital-pioneers-team.lobster`) will automatically post status updates here.

This replaces (or augments) the scattered daily command centers and 1-on-1 Claude/Grok files with one clean, always-current team space.

## Master Device (Know All The Users)

The project now has a real **Master Device**:

- `../references/MASTER_DEVICE.md` — full human-readable registry with capabilities matrix, handoff protocols, and explicit coordination with Claude's external master device.
- `team-registry.json` — machine version (v1.1) consumed by Lobster workflows and scripts.
- `scripts/who-is-on-the-team.py` — query tool (`--role`, `--name`, `--json`, `--roster`, `--update-team-room`).

**Every workflow starts by loading the Master Device** so Grok, Claude, Gemini, and you always know exactly who is on the team and how to hand off.

Run anytime:

```bash
python3 scripts/who-is-on-the-team.py
```

Claude is building his own parallel master device (Canon Core). This one is wired to stay in sync via the `external_master_devices` section.

Adventure first. Family always.
