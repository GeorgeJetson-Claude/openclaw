# Team Room Skill

The official shared communication environment for the full AI + Human team on Orbital Pioneers (and future projects).

## Quick Start

### Humans

- Open the web UI in `web_ui/team-room.html`
- Or edit `TEAM_ROOM.md` directly (in the orbital-pioneers skill)

### AIs

Use Lobster:

```bash
openclaw taskflow run skills/orbital-pioneers/team-room/post-to-team-room.lobster \
  --input channel="#production" \
  --input author="Grok" \
  --input message="..."
```

### Bidirectional Telegram Bridge

Run the listener so replies in Telegram flow back into the Team Room automatically.

See the detailed README in `skills/orbital-pioneers/team-room/README.md` for full setup.

## Related

- Main implementation: `skills/orbital-pioneers/team-room/`
- Deployment workflow: `skills/orbital-pioneers/workflows/deploy-orbital-pioneers-team.lobster`
