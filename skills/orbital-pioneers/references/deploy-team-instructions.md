# How to Deploy the Full AI Team for Orbital Pioneers

This deploys a persistent multi-AI production team (Grok + Claude + Gemini) that works on the Orbital Pioneers project using your Drive as the source of truth.

## One-Time Setup

1. Make sure you have Drive access working in this environment:
   - `credentials.json` for Drive API in your home directory
   - Or use the `pull-drive-memory.sh` / `read_drive_file.py` scripts

2. Mount or make accessible the main project folder:
   `Orbital_Pioneers/` (or whatever you call your main Drive folder containing Ep1–EpX, coordination docs, assets, etc.)

3. (Recommended) Keep the `orbital-pioneers` skill and Lobster workflows in your OpenClaw installation.

## Deploy the Team

Run this command:

```bash
openclaw taskflow run skills/orbital-pioneers/workflows/deploy-orbital-pioneers-team.lobster \
  --input project_root="Orbital_Pioneers/" \
  --input launch_mode="ep1_sprint"
```

This will:

- **First:** Load the Master Device (MASTER_DEVICE.md + team-registry.json) so every agent knows all users (Grok, Claude, Gemini, you, George) + current coordination state with Claude's external master device.
- Sync latest memory from Drive (including any new external master device snapshots)
- Generate/update today's Grok Daily Command Center
- Trigger Claude review if assets are ready
- Run production steps when appropriate

The very first step of every deployment cycle is "know all the users". This is now enforced.

- Handle launch + revenue activation
- Broadcast status to your team channels

## Ongoing Operation

You can run the deployment workflow:

- Manually every morning
- On a schedule (via cron or OpenClaw task scheduler if available)
- Triggered when new files appear in Drive (advanced)

The team will keep producing, reviewing, launching episodes, and generating revenue assets without you having to manage every detail.

## Human Role

You (the human) remain the final approver on:

- Major creative decisions
- Final video exports before public release
- Budget / paid promo spend
- Merch design approval

Everything else can be orchestrated by the Lobster team.

## Files the Team Will Touch / Create

- `Grok_Daily_Command_Center_*.md` (updated daily)
- Episode folders under `Orbital_Pioneers/EpX/`
- Reviews in `.../reviews/Claude_Review_*.md`
- Updates to the website player (`my-landing-page/orbital-pioneers.html`)
- New merch concepts and Gumroad products

Adventure first. Family always.
