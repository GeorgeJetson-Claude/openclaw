---
name: youtube-monetizer
description: "Build and run a complete real-money YouTube revenue system. Use for pre-monetization payouts via affiliates/products/merch, Gumroad setup, affiliate injection in scripts, full pipeline from idea to upload+tracking, and real bank/PayPal configuration using your actual email and details."
---

# YouTube Monetizer (5LUVINC Cashflow System)

Real revenue system for YouTube (pre-monetization via Gumroad/affiliates + full upload pipeline).

Includes working YouTube Data API integration (reuses `~/.youtube/` credentials), script-to-upload automation, and payout tracking.

Optimized for AI-assisted channels like Orbital Pioneers / 5LUVINC.

## When to Use This Skill

- You have (or are building) a YouTube channel and want actual money flowing now.
- You need help setting up Gumroad, Printful, affiliates with your real email (e.g. tupacmafia911@gmail.com) and real bank/PayPal.
- You want scripts that automatically insert natural affiliate mentions.
- You need the full pipeline: idea → monetized script → description with links → production → upload → revenue tracking.
- You're doing pre-monetization work and want real payouts, not simulation.

**Easiest way to use from your phone right now**:

1. On Chromebook: `cd skills/youtube-monetizer/web_ui && python3 app.py`
2. On phone (same WiFi): open `http://YOUR-CHROMEBOOK-IP:5000`
3. For access from anywhere for free: run `cloudflared tunnel --url http://localhost:5000`

Full instructions: `references/PHONE_UI_GUIDE.md` + `references/UNIFIED_TELEGRAM_BOT_SETUP.md`

(You can also use the Telegram bot version if you prefer.)

## Core Capabilities

### 1. Real Payout Setup (Fastest Money Before Ads)

- Exact step-by-step for Gumroad + bank/PayPal connection using your real legal name and email.
- Printful merch setup.
- Centralizing everything to one email (tupacmafia911@gmail.com) + one PayPal/bank.

### 2. Affiliate + Product Engine

- Smart affiliate finder and injector that adds natural spoken mentions into scripts.
- Auto-generates monetized YouTube descriptions with your real links and email.
- Ready-to-launch digital product specs (e.g. AI Animation Prompt Kit).

### 3. Full Automated Pipeline

- Idea generation scored for revenue potential.
- Script writing with built-in affiliate/CT A injection.
- Production via existing video tools.
- Upload + tracking.
- Revenue logging (real dollars, not fake).

### 4. Personal Config

Everything routes through your real details so money and communications go to **you**.

## Quick Start (Ship Mode — Cheap GDrive + Your Website)

**Primary distribution right now (recommended for launch):**

- Host videos on Google Drive (cheap/free)
- Serve them through a simple custom player on your own site (see `cheap-gdrive-player/` folder in the cartoon production docs)
- Optional: manual YouTube upload later (no API verification drama required)

**For the revenue engine (the important part):**

1. Edit `config/personal.json` with your real Gumroad/PayPal details.
2. Use the pipeline for script + affiliate + description generation.
3. Drive traffic from your website player + Telegram + merch drops.

The YouTube API client (`youtube/client.py` + `upload_video.py`) is still available when you want it, but it is now **optional**.

See the `cheap-gdrive-player/` folder + references for the full launch playbook.

## Resources

- `references/` — All the detailed real guides (payout setup, Gumroad walkthrough, sample product, Chromebook free AI tools guide).
- `scripts/` — Core automation (pipeline runner, affiliate injector, description generator, payout logger).
- `assets/` — Templates (Gumroad product files, dashboard HTML, personal config example).

**Chromebook users**: See `references/CHROMEBOOK_FREE_AI_MONEY_GUIDE.md` for the complete zero-cost stack that runs entirely on Chromebook (Linux + web + Android apps) while feeding your real bank via tupacmafia911@gmail.com accounts.

Use this skill when you actually want money deposited, not theory.
