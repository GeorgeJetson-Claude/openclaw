# Phone Web UI - One Free Page Controller

This is the simplest way to command everything from your phone.

**Full step-by-step instructions** (highly recommended):
→ See `references/UNIFIED_TELEGRAM_BOT_SETUP.md` (has a section for the web UI)  
 or the even clearer guide in your personal project:  
 `5LUVINC/monetization/docs/phone_ui/HOW_TO_ACCESS_FROM_PHONE.md`

## Quick Start

1. On Chromebook Linux:

   ```bash
   cd skills/youtube-monetizer/web_ui
   pip3 install flask google-generativeai anthropic
   python3 app.py
   ```

2. On your phone (same WiFi):
   Open `http://YOUR-CHROMEBOOK-IP:5000`

3. For access from anywhere (free):
   Use Cloudflare Tunnel:
   ```bash
   cloudflared tunnel --url http://localhost:5000
   ```

The page is fully mobile-optimized with:

- Password protection
- Big one-tap buttons for your money tasks
- Installable as a real app on your phone home screen (PWA)

It directly supports your 5LUVINC money system and all OpenClaw skills.
