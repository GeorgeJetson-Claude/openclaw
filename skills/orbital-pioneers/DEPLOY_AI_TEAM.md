# DEPLOY AI TEAM — Orbital Pioneers

This is the single entry point to activate the full autonomous (or semi-autonomous) AI production team for your cartoon.

## One Command to Deploy the Team

```bash
cd ~/projects/OpenClaw

openclaw taskflow run skills/orbital-pioneers/workflows/deploy-orbital-pioneers-team.lobster \
  --input project_root="Orbital_Pioneers/" \
  --input launch_mode="ep1_sprint"
```

## What This Activates

- Daily Grok Command Center updates (memory sync from Drive)
- Claude review cycles on ready assets
- Gemini generation tasks (audio, prompts, storyboards)
- Full production pipeline (generate-episode)
- Launch automation (GDrive + website player)
- Merch and paid promo generation
- Team notifications (Telegram/Discord/etc.)

The team will keep working on Ep1 launch, Ep2 planning, merch, and revenue in parallel.

## Human Oversight Points

You still control:

- Final creative approvals
- Major spend decisions
- When to trigger paid promo
- Final video sign-off before public release

Everything else can run on the Lobster orchestration.

## Files Created / Managed by the Team

- `Grok_Daily_Command_Center_*.md` (in your coordination folder)
- Episode folders with layers, audio, renders
- Reviews from Claude
- Updated website player
- New merch concepts and Gumroad products

## Next Steps After First Run

1. Review the generated Daily Command Center.
2. Approve or adjust any tasks.
3. Run individual workflows as needed (e.g. `launch-ep1.lobster` or `claude-review.lobster`).
4. Re-run the deploy workflow daily or when new Drive content appears.

**Adventure first. Family always.**

Deploy the team and let it run.
