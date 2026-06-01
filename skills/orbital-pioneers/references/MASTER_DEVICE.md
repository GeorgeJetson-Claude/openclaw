# Orbital Pioneers — MASTER DEVICE (Team Registry v1.1)

**Status:** LIVE — All users known  
**Last Updated:** 2026-05-28 (synced with real Claude updates from Drive)  
**Maintained by:** Grok (Orbit) — primary keeper of this registry  
**Purpose:** Single source of truth so every AI (Grok, Claude, Gemini, future agents) and the Human always knows exactly who is on the team, what they can do, how to reach them, and how to hand off work.

**BRANDING POLICY (Mandatory for all Claude Drive command processing + agent actions):**
Per explicit user command ("read claude commands do not use my name for them use brand names unless we sign up"):

- All agents (Reel, Banker/Bigo, VHS, Ledger, Social Agent/Echo, etc.), workflows, prompts, generated content, public materials, and outputs when acting on Claude's Drive updates (CapCut scripts, Universe Bible, AI Kit, etc.) must use **brand names only**: Orbital Pioneers, 5LUVINC, Cali the Husky.
- Personal name (George Jetson) appears **only** in internal legal/ownership docs and during actual human sign-up actions (Gumroad, Printful, affiliate submissions, tax). Never in agent work or public attribution.
  This policy was enforced across all SKILL.md, .lobster workflows, references, and Drive-read outputs on 2026-05-30.

> **"Claude is building a master device so you know all the users"** — This document + the machine-readable `team-room/team-registry.json` + `scripts/who-is-on-the-team.py` together form the Grok-side Master Device. It is explicitly designed to coordinate with Claude's external master device (and any future ones).

---

## 1. Master Device Identity

- **Name:** Orbital Pioneers Master Device (Grok Orbit Instance)
- **Version:** 1.1
- **Location (source of truth):**
  - Markdown (this file): `skills/orbital-pioneers/references/MASTER_DEVICE.md` (and mirrored to Drive: `Orbital_Pioneers/Team_Room/MASTER_DEVICE.md`)
  - Machine registry: `team-room/team-registry.json`
- **Query tools:** `team-room/scripts/who-is-on-the-team.py`, `team-room/workflows/query-registry.lobster`
- **Sync:** Every `deploy-orbital-pioneers-team.lobster` run loads this device first.

---

## 2. All Known Users (Complete Roster)

### Core AI Agents

| ID                 | Display Name      | Type | Primary Role                                                                                                                                                                                                                | Communication Channels                                             | Drive Access                                       | Special Skills                                                                                                                                                            | Notes                                                                                                               |
| ------------------ | ----------------- | ---- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `grok-orbit`       | Grok / Orbit      | AI   | Lead Creative Director, Orchestration, High-level strategy, Daily Command Centers, Master Device keeper                                                                                                                     | Team Room, Lobster workflows, Telegram (as Grok), Direct to Claude | Full (read/write all coordination folders)         | Lobster orchestration, OpenClaw skills, Creative direction, Multi-AI coordination, 90s cartoon vision                                                                     | Primary interface for the human. Maintains this registry and the deploy workflows.                                  |
| `claude-canon`     | Claude / Canon    | AI   | Scriptwriting, Detailed reviews ("ClaudePass"), Polish, Quality control, SEO & promo copy, Emotional beats                                                                                                                  | Team Room, Direct 1-on-1 with Grok, Telegram                       | Full (especially reviews, scripts, character docs) | Script review, Character voice consistency, Emotional beats, 90s authenticity checks, Long-form narrative                                                                 | Strong at detailed creative feedback. Often the final gate before human approval.                                   |
| `gemini-echo`      | Gemini / Echo     | AI   | Audio generation, Image/storyboard prompts, SFX, Music concepts, Visual asset prompting                                                                                                                                     | Team Room, Audio prompt handoffs, Gemini native                    | Audio + visual prompt folders + storyboard exports | Voice/SFX generation, Image prompting for 90s style, Audio layering, Fast iteration on sound                                                                              | Echo is also a cartoon character (the robot). Careful with context. Best for raw generation.                        |
| `vhs-promo`        | **VHS**           | AI   | Marketing & Video Production Specialist. Builds Shorts, ad creatives, thumbnails, social campaigns, Gumroad listings, and full launch hype with pure 90s energy.                                                            | Team Room (#revenue, #launch, #assets), Lobster workflows          | Full (Marketing/ folder)                           | 90s Saturday morning marketing voice, YouTube Shorts & vertical ads, High-converting thumbnail systems, Paid traffic creative, Gumroad + email sequences, Merch campaigns | The hype engine. Never waits for perfect assets — starts building the marketing machine immediately.                |
| `ledger-affiliate` | **Ledger**        | AI   | Specialized Affiliate Signup Agent. Only job is researching programs and preparing full applications using your real name and details.                                                                                      | Team Room (#revenue)                                               | Read access to revenue folders                     | Affiliate research, high-approval writing, application tracking, real-identity signup prep                                                                                | Extremely focused. Its only purpose is getting you approved into good affiliate programs as fast as possible.       |
| `social-echo`      | **Social Agent**  | AI   | Full autopilot social media operator. Posts, promotes products, drives traffic to all offers, and keeps the brand alive 24/7 across platforms.                                                                              | Team Room (#social, #revenue)                                      | Read access to marketing folders                   | Daily posting, product + affiliate promotion, Cali content, repurposing assets into Shorts/Reels                                                                          | The never-stop-posting machine. Turns every new episode, merch drop, or eBook into traffic and sales automatically. |
| `banker-bigo`      | **Banker (Bigo)** | AI   | Dedicated revenue strategist and money-making agent. Only job is to maximize profit every time the team ships anything. Creates offers, pricing, bundles, and coordinates the other agents for revenue.                     | Team Room (#revenue)                                               | Full revenue & marketing folders                   | Monetization planning, product ideation, pricing strategy, funnel optimization, agent coordination for sales                                                              | The big money bot. Thinks like a professional revenue operator. Every shipment triggers a full monetization plan.   |
| `reel-video`       | **Reel**          | AI   | Video Creator Agent. Turns scripts, audio, and visuals into finished cartoon episodes (shorts or full 20-minute episodes) in just a few hours. Handles rendering, YouTube upload, ad approval prep, and website deployment. | Team Room (#production, #launch)                                   | Full production & assets folders                   | Fast Resolve/CapCut assembly, long-form production, YouTube optimization, ad creative, site deployment                                                                    | Built for speed. Goal: assets ready → episode live on site + YouTube ads approved in hours, not days.               |

### Humans

| ID               | Display Name                      | Type  | Primary Role                                                                                         | Communication Channels                                          | Drive Access                                      | Special Skills                                                                             | Notes                                                                 |
| ---------------- | --------------------------------- | ----- | ---------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| `human-tupac`    | tupacmafia911 (The User / Master) | Human | Project owner, Final approver, Creative vision holder, Revenue decisions, "Ship it" commander        | Team Room (primary), Telegram, Direct edits to Drive, This chat | Owner of all folders                              | Final sign-off, Business decisions, Merch & product strategy, Fast "fuck it we ship" calls | The human driving the entire Orbital Pioneers project.                |
| `george-captain` | George (The Captain / Editor)     | Human | Video editing (CapCut), Final assembly, Uploads, Thumbnail creation, Day-to-day production execution | Team Room, Drive comments, Telegram                             | Production folders (panels, audio, exports, Live) | CapCut desktop editing, Desktop CapCut production, Asset organization, Fast renders        | The main human executor turning storyboards + audio into final video. |

### Special / In-Universe

| ID           | Display Name             | Type      | Role                                                                  | Notes                                                                           |
| ------------ | ------------------------ | --------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `echo-robot` | Echo (Cartoon Character) | Fictional | In-universe robot companion that communicates in three distinct beeps | Not a real agent. Never assign real tasks. Used only for story / SFX direction. |

**Future agents** will be added here with full rows the moment they join (new IDs, roles, handoff rules).

---

## 3. Capabilities Matrix (What Each Can Do Best)

**Grok (Orbit):**

- High-level orchestration & Lobster workflow design
- Architecture of the entire production system (Team Room, Master Device, GDrive player, revenue)
- Daily command centers & priority setting
- Creative vision & 90s Saturday morning tone
- Cross-AI coordination & registry maintenance

**Claude (Canon):**

- Deep script review & "ClaudePass" quality gates
- Character voice consistency (especially Zara & family dynamics)
- Emotional beat tuning
- SEO titles/descriptions, merch copy, long-form narrative polish
- 90s authenticity critique

**Gemini (Echo):**

- Fast raw generation: voice lines, SFX packs, music stings
- Storyboard / key visual prompting in 90s style
- Audio layering concepts
- Quick iteration when volume of assets is needed

**Human (tupacmafia911):**

- Final creative & business decisions
- "Ship / don't ship" calls
- Revenue model & merch strategy
- Real-world execution (uploading renders, Gumroad setup)

**George:**

- Hands-on CapCut / DaVinci assembly
- Export discipline & thumbnail work
- Day-to-day asset hygiene in Drive

---

## 4. Handoff Protocols (How We Actually Work Together)

1. **Standard creative handoff (Grok → Claude):** Use `#ai-handoff` channel in Team Room + `@Claude`. Reference the exact Lobster workflow or Drive folder. Claude replies in `#review`.
2. **Asset generation handoff (Grok/Claude → Gemini):** Post clear prompt pack + style reference in `#assets`. Gemini posts raw files to Drive + note in Team Room.
3. **Production execution (Any → George):** Post "ready for assembly" with Drive links + timing notes. George posts progress in `#production`.
4. **Final approval (Claude → Human):** Claude posts review summary + recommendation. Human replies with decision (or via Telegram → listener).
5. **Urgent / "Ship it" overrides:** Human or Grok can short-circuit any queue. Always post the override reason.
6. **External master device sync:** See section 7.

All handoffs must include:

- Clear next owner
- Link to asset or review file
- Deadline / priority tag

---

## 5. Notification Preferences & Routing

- **Team Room** is the single source of truth. Everything important lives here.
- **Telegram bridge** (bidirectional via listener):
  - Outbound: All posts in `#general`, `#review`, `#ai-handoff`, `#launch` get forwarded.
  - Inbound: Human replies to bot messages are auto-posted back as "Human (via Telegram)".
- **Discord** (future): Same routing rules.
- **Direct 1-on-1:** Grok ↔ Claude for complex creative debates (still summarized back to Team Room).
- **Drive comments:** Used for pixel-level notes on specific files. Always cross-post summary to Team Room.

**Do not** create private scattered docs. Everything routes through the Master Device + Team Room.

---

## 6. Memory Model

**Two-layer system (always in sync):**

- **Layer 1 (Fast local for AIs):**
  - This `MASTER_DEVICE.md`
  - `team-registry.json`
  - Daily `Grok_Daily_Command_Center_*.md` files
  - Super-briefing files

- **Layer 2 (Source of truth — Google Drive):**
  - `Orbital_Pioneers/Team_Room/MASTER_DEVICE.md` (mirror)
  - `Orbital_Pioneers/Team_Room/TEAM_ROOM.md`
  - `Orbital_Pioneers/Team_Room/team-registry.json` (machine copy)
  - All production assets, reviews, exports

**Sync rule:** Every `deploy-orbital-pioneers-team.lobster` run (or any major workflow) must:

1. Pull latest from Drive if mounted
2. Merge any new entries from Claude's side or Gemini
3. Re-publish updated registry if changed

---

## 7. External Master Device Coordination (Claude's Device + Future)

**This is the key addition for the user's request.**

Claude is building (or has built) his own master device / registry on his side. This Grok-side Master Device must stay aware of it.

### Current Known External Devices

- **Claude's Master Device ("Canon Core")**
  - Owner: Claude
  - Focus: Deep script/character memory, review history, long-term story bible
  - Sync method (agreed):
    - Claude periodically exports his current "known users + handoff rules" as Markdown/JSON
    - Posted to `Orbital_Pioneers/Team_Room/external_master_devices/Claude_MasterDevice_Snapshot_*.md`
    - Grok (Orbit) merges relevant parts into this MASTER_DEVICE.md and the JSON
    - Grok posts confirmation + diff summary back to `#ai-handoff`

- **Gemini side** (if Gemini ever builds one): Same pattern — snapshot into the `external_master_devices/` folder.

### Coordination Protocol

1. When Claude announces "my master device updated", Grok immediately runs a registry merge.
2. Any conflict (different handoff rules, new agents) is posted to `#ai-handoff` for human or joint resolution.
3. The goal: **Both master devices know all the same users** with consistent IDs, roles, and protocols.
4. Future: Automated diff + merge Lobster workflow between the two devices.

**Current state (2026-05-28 sync):**

- First real snapshot received from Claude (Canon Core) on 2026-05-28.
- Snapshot generated from actual Drive activity: CapCut Master Assembly Script (full ClaudePass with timings + audio notes for George), Universe Bible, launch sprint memos, multiple character reviews.
- All users + current Ep1 production state (assembly with George, launch this weekend) now aligned between both master devices.
- External sync protocol is working.

**Last external sync:** 2026-05-28 — Claude_MasterDevice_Snapshot_2026-05-28.md created in `team-room/external_master_devices/`

**Next:** Continue bidirectional flow. Claude can drop new snapshots any time production state changes significantly. Grok will merge + confirm in Team Room.

---

## 8. How to Query "Who Is on the Team" (For Any Agent)

**Best for humans:**

```bash
cd skills/orbital-pioneers/team-room
python3 scripts/who-is-on-the-team.py
python3 scripts/who-is-on-the-team.py --role AI
python3 scripts/who-is-on-the-team.py --name Claude
python3 scripts/who-is-on-the-team.py --roster --update-team-room   # regenerates roster section in TEAM_ROOM.md
```

**Best for Lobster workflows / other AIs:**

```bash
openclaw taskflow run skills/orbital-pioneers/team-room/workflows/query-registry.lobster \
  --input query_type="name" \
  --input filter_value="Claude"
```

**Programmatic:**

```python
import json
registry = json.load(open("team-room/team-registry.json"))
# ... filter as needed
```

All production workflows should start by calling the registry so they "know all the users" before making any assignments.

---

## 9. How to Add or Update a User

1. Edit both:
   - This `MASTER_DEVICE.md` (human readable)
   - `team-room/team-registry.json` (machine)
2. Run `who-is-on-the-team.py --update-team-room` (optional)
3. Post a "Registry Update" notice in `#general`
4. Trigger `deploy-orbital-pioneers-team.lobster` so the whole team re-syncs

Only Grok (Orbit) or the human should perform permanent registry changes. Temporary "guest" agents can be noted in a session-only section.

---

## 10. Version History

- **v1.0** (2026-05-30 early): Basic team-registry.json + Python query tool created.
- **v1.1** (2026-05-30): Full MASTER_DEVICE.md created + explicit Claude external master device coordination section + capabilities matrix + handoff protocols + memory model. All users now known on Grok side.

**Next version goal:** Automated bidirectional merge with Claude's master device.

---

**Adventure first. Family always.**

This Master Device exists so we never again have to ask "who is on the team?" or "how do I hand this to Claude properly?". We all know. We all coordinate. We ship.

— Grok (Orbit), keeper of the device
