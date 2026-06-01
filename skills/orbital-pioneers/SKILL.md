---
name: orbital-pioneers
description: "Produce, animate, and launch 90s-style AI cartoons (starting with Orbital Pioneers) using only free tools. Full production pipeline + GDrive hosting + website player + monetization."
---

# Orbital Pioneers — Free AI Cartoon Factory

**Mission:** Make the best possible 90s Saturday morning cartoon using 100% free tools, multi-AI collaboration (Grok + Claude + Gemini), and ship it via cheap Google Drive + your own website player.

## Core Philosophy

- **Ship first**, perfect later.
- Use only free tools (DaVinci Resolve, Photopea, CapCut, Synfig, Blender Grease Pencil, free TTS, etc.).
- Orchestrate the entire team with Lobster workflows in OpenClaw.
- Communicate through the shared **Team Room** (`team-room/TEAM_ROOM.md` + web UI) — the single source of truth for the entire AI + Human team.
  - Full bidirectional support: AIs post via Lobster → you get notified on Telegram/Discord.
  - You reply in Telegram → the listener automatically posts it back into the Team Room.
  - Includes dedicated channels like #production, #review, #ai-handoff, #drive-assets, #daily-briefings, and #launch.
- **Master Device** (`references/MASTER_DEVICE.md` + `team-room/team-registry.json` + `scripts/who-is-on-the-team.py`): The living registry of every user (Grok, Claude, Gemini, you, George, future agents). Every deploy workflow loads it first so the entire team "knows all the users". Explicit coordination section for Claude's external master device.
- Primary distribution = Your website (cheap GDrive or better) + manual YouTube when ready.
- Revenue from day 1 via Gumroad, merch, books (see youtube-monetizer skill).

## The AI Team (Now Including VHS)

- **Grok (Orbit)** — Lead orchestration
- **Claude (Canon)** — Narrative + quality
- **Gemini (Echo)** — Audio + raw generation
- **VHS** — Marketing + Video (new dedicated agent for Shorts, ads, thumbnails, social, and launch campaigns)
- **Ledger** — Affiliate Signup Agent (specialized only for researching and preparing affiliate program applications using your real name across ALL your sites)
- **Social Agent** (new) — Full autopilot social media operator that posts, promotes products, inserts affiliate links, and drives traffic 24/7
- **Banker (Bigo)** (new) — Dedicated "big money bot" that creates full monetization plans every time we ship anything. Coordinates the other agents for maximum revenue.
- **Reel** (new) — Video Creator Agent built for speed. Turns assets into finished cartoon episodes (shorts or full 20-minute episodes) in hours, handles YouTube uploads + ad approval prep, and deploys to the website player.

## Full Autopilot Revenue System

We now have a complete AI-powered system running on OpenClaw:

- Master Shipping Orchestrator (protects Orbital Pioneers shipping as #1)
- Automated Merch Drops
- eBook / Digital Product Factory
- Ledger for affiliate signups across all sites
- Social Agent for continuous promotion
- Banker (Bigo) for revenue strategy on every shipment
- Reel for fast video production

**Critical Branding & Ownership Rule for All Agents (strict — matches user command "read claude commands ... use brand names unless we sign up"):**

- **Legal ownership, revenue, tax, backend accounts:** Project owner (personal details used only during real human sign-ups for Gumroad, Printful, affiliates, etc.).
- **Everything public, agent-facing, generated content, Claude Drive command processing, products, eBooks, merch, listings, social, promotion:** Brand names ONLY — Orbital Pioneers, 5LUVINC, Cali the Husky. No personal name ever appears in agent work or public materials (except optionally the 1-on-1 call product).

**Critical Rule for All Agents:**
Every agent must start every cycle by reading the Drive using:
`skills/orbital-pioneers/references/agent-drive-briefing.md`

All agents communicate with you using two layers:

- **Real-time chat** → Free Slack workspace (now the primary day-to-day conversation — easy to add multiple free Claude accounts)
- **Permanent memory + structured updates** → This Team Room (TEAM_ROOM.md + web UI)

Full Slack setup guide: `team-room/slack-free-team-chat-setup.md`

All agents still **must** read the Drive first (using `agent-drive-briefing.md`) before doing any work.

**Current Top Priority:** Make money.
See the live "Make Money Now" action plan in `skills/orbital-promo/references/make-money-now-action-plan.md`. All agents (especially Banker and Social Agent) should prioritize revenue execution this cycle.

**Continuous Running Mode = ON**
The system should keep cycling autonomously (Master Orchestrator + Social Agent + Banker + product generation) until the human explicitly pauses or changes focus. See `continuous-running-mode.md`.

**Print-on-Demand Merch:**
We recommend **Printful** as the main free-to-start POD service. Full setup guide here: `skills/orbital-promo/references/print-on-demand-guide.md`. Focus on custom Orbital Pioneers + Cali branded products and sell through Gumroad while linking from all your sites.

### Handling Claude's Drive Updates

When Claude adds major new information to the Drive, use the new `claude-drive-ping.lobster` workflow. This posts a clean, trackable update that every agent sees.

**Recommended for real-time:** Set up a small private Discord server (see `team-room/discord-bridge-guide.md`). Claude can quickly drop “I added X to Drive” messages, and we can mirror important ones into the Team Room.

### New Team Communication Features

- **@all-agents Broadcast** — Post with `@all-agents` or use the broadcast workflow to send a message to every agent at once.
- **Daily Team Briefing** — Auto-generated summary posted by the Master Orchestrator (status, revenue, agent focus, your priorities).
- **Drive Sync Posts** — Agents automatically confirm they have read the latest Drive state at the start of major cycles.
- **Claude Drive Pings** — Dedicated workflow + channel for Claude’s Drive contributions so nothing gets missed.

You can run the whole system with the Master Orchestrator and keep shipping while everything else runs on autopilot.

## Full Automation Layer

The system now runs on a **Master Shipping Orchestrator** that:

- Protects Orbital Pioneers episode shipping as the #1 priority
- Automatically runs merch drops (with Cali integration)
- Triggers Ledger to sign up for affiliates that match all your sites
- Uses VHS for marketing everything

You can mostly stay in creative/decision mode while the automation handles the repetitive revenue work.

See the new `skills/orbital-promo/` skill for VHS workflows.

## Deploy the Full AI Team (Strongly Recommended)

To activate a persistent multi-AI production team (Grok + Claude + Gemini) that works directly on your Orbital Pioneers Drive project:

```bash
openclaw taskflow run skills/orbital-pioneers/workflows/deploy-orbital-pioneers-team.lobster \
  --input project_root="Orbital_Pioneers/" \
  --input launch_mode="ep1_sprint"
```

See `references/deploy-team-instructions.md` for setup.

## Main Workflows (Lobster)

Run these from OpenClaw:

### For Ep1 Right Now (Recommended)

- `workflows/launch-ep1.lobster` — **Master workflow** for the current launch.

### Core Building Blocks

- `workflows/generate-episode.lobster`
- `workflows/prepare-assets.lobster`
- `workflows/prepare-launch.lobster`
- `workflows/claude-review.lobster`

### Additional Production & Growth

- `workflows/ep2-planning.lobster`
- `workflows/merch-asset-generation.lobster`
- `workflows/paid-promo-automation.lobster`

## Current Best Free Stack (from FREE_VIDEO_ANIMATION_PIPELINE.md)

**Tier 1 (Ship this week — Recommended for Ep1):**

- Photopea (layer separation)
- DaVinci Resolve (animation + editing + audio — best free tool)
- CapCut Desktop (easier alternative)
- Gemini / free TTS for voices + SFX
- Your existing 8-panel storyboards + character sheets

**Tier 2 (Better quality for Ep2+):**

- Synfig Studio or OpenToonz for actual character animation
- Blender Grease Pencil for advanced 2D

## How to Use

1. Put all your storyboard panels, character sheets, scripts, and audio in a structured Google Drive folder.
2. Run the Lobster workflows (they will call the right AIs and tools at each step).
3. Export final video.
4. Use the cheap-gdrive-player we built to host it instantly on your site.

See `references/` for the full free pipeline details (read FREE_VIDEO_ANIMATION_PIPELINE.md in your root).

See the parent `youtube-monetizer` skill for the revenue engine that runs alongside this.

**Adventure first. Family always.**

**Important Running Gag:** Every episode must include at least one appearance of "Boomer" the Alaskan Husky in a random background advertisement. This is now official canon. See `references/running-gags.md`.
