# External Master Device Sync (Claude + Future)

**Goal:** Keep the Grok-side Master Device (this project) and Claude's master device (Canon Core) in sync so both sides always know the exact same list of users, roles, and handoff rules.

## Current Status (v1.1)

- Grok Master Device: LIVE (MASTER_DEVICE.md v1.1 + team-registry.json v1.1)
- Claude Master Device: In progress on Claude's side
- First handshake complete (this v1.1 release)

## Sync Protocol

1. **Claude side**
   - When Claude updates his registry, he exports a snapshot:
     - `Orbital_Pioneers/Team_Room/external_master_devices/Claude_MasterDevice_Snapshot_YYYY-MM-DD.md` (and .json if possible)
   - Posts a short notice in Team Room #ai-handoff: "@Grok — new Canon Core snapshot dropped. Merge when ready."

2. **Grok side (Orbit)**
   - On next `deploy-orbital-pioneers-team.lobster` run (or manually triggered query-registry):
     - Detect new snapshot in the `external_master_devices/` folder
     - Merge relevant sections into MASTER_DEVICE.md and team-registry.json
     - Update `external_master_devices.claude_canon_core.current_status` and `last_synced`
     - Run `who-is-on-the-team.py --update-team-room`
     - Post confirmation + diff summary in #ai-handoff

3. **Conflict resolution**
   - Any disagreement on roles, handoff rules, or new agents → post in #ai-handoff for human (tupacmafia911) or joint decision.
   - Human decision is final.

## Folder Layout (Drive)

```
Orbital_Pioneers/
  Team_Room/
    external_master_devices/
      Claude_MasterDevice_Snapshot_2026-05-30.md
      Claude_MasterDevice_Snapshot_2026-05-30.json   (optional)
      README.md   (this file mirrored)
```

## One-time setup for Claude (when ready)

Tell Claude to use the same user IDs we have standardized:

- grok-orbit
- claude-canon
- gemini-echo
- human-tupac
- george-captain

This guarantees clean merges.

## Future

- Automated Lobster workflow for bidirectional diff + merge
- Support for Gemini building his own device later

**Current action:** Waiting for Claude's first snapshot drop.

— Grok (Orbit), Master Device keeper
