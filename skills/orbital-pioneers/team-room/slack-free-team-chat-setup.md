# Free Slack Workspace Setup for Orbital Pioneers AI Team

**Goal:** One real-time group chat where you + all AI agents (including multiple free Claude instances) can talk, while still using the Drive + Team Room as the single source of truth.

Slack free plan is perfect for this:

- Unlimited members
- Good search
- Easy to add Claude free accounts
- Can be used alongside our existing Team Room + automation

---

## Step-by-Step: Create Your Free Slack Workspace

1. Go to https://slack.com and click **"Create a new workspace"** (or sign up with your Google account — same one as your Drive/Gumroad for consistency).

2. Name the workspace something like:
   - `orbital-pioneers`
   - `robb-Jetson-team`
   - `5uv-media`

3. Use your main email (the one tied to your Google account).

4. Invite yourself first to confirm it works.

---

## Recommended Channel Structure

Create these channels right away:

**Core Channels:**

- `#general` — Main ongoing chat (you + all agents)
- `#drive-updates` — Where Claude (and agents) post when they add major things to Drive (this replaces scattered pings)
- `#production` — Episode production, Reel updates, assets
- `#revenue` — Merch, eBooks, Gumroad, affiliates, Banker updates
- `#agent-sync` — Broadcasts and coordination (equivalent to our @all-agents)
- `#claude-pings` (optional) — Dedicated if you want to keep Claude's updates very clean

**Optional but useful:**

- `#voice` — For actual voice calls if needed
- `#ideas` — Random brainstorming
- `#social` — What the Social Agent is posting

---

## How to Add Free Claude Accounts

1. Go to https://claude.ai and create as many free accounts as you want (use different emails or +aliases if needed).
2. In Slack, go to your workspace settings → **Invite people**.
3. Invite each Claude free account email.
4. Once they accept, they can join the channels.

**Tip:** Name the Claude accounts clearly, e.g.:

- claude-canon@yourdomain.com
- claude-narrative@...
- claude-review@...

This makes it easy to @mention specific Claude instances.

---

## How the AI Agents Should Use Slack

- All agents (including future ones) should be instructed to:
  - Read the Drive first (using our `agent-drive-briefing.md`)
  - Post important updates in the relevant Slack channel
  - Especially use `#drive-updates` when Claude (or any agent) adds major new info to Drive

- You can still use the Lobster `post-to-team-room.lobster` workflow to mirror important Slack messages into the Team Room Markdown for long-term memory.

---

## Bridging Slack ↔ Team Room (Recommended)

For now (manual but effective):

- When something important happens in Slack, the human or Social Agent can run the existing `post-to-team-room.lobster` to log it in the Team Room.

Future automation (we can build this):

- Extend the Social Agent to watch specific Slack channels and auto-post summaries to the Team Room.
- Or use Slack's incoming webhooks + a simple script.

---

## Security & Ownership Note

- Keep the Slack workspace private.
- All content and revenue follow the strict brand-names-only rule for agents and public materials (see `all-in-my-name-ownership.md`). Real personal details used only at actual sign-up time.
- Do not give admin rights to any AI accounts.

---

## Quick Start Checklist

- [ ] Create Slack workspace with your main Google account
- [ ] Create the recommended channels
- [ ] Invite your Claude free accounts
- [ ] Pin this guide + the `agent-drive-briefing.md` in #general
- [ ] Tell Claude (and the other agents) to start using #drive-updates for Drive pings
- [ ] Run the Social Agent with instructions to also consider Slack

This setup gives you the real-time "in and out" chat you wanted with Claude and the agents, while keeping the Drive + Team Room as the permanent source of truth.

Once it's set up, we can update the Social Agent, Master Orchestrator, and all other agents to treat Slack as the primary real-time layer.

Let me know when the workspace is created and I’ll help you configure the agents to use it properly.
