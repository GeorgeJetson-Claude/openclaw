# Super Grok Unified Interface - Telegram Bot Setup (Chromebook)

This gives you **one free app** (Telegram) to talk to:

- Grok
- Gemini (free tier)
- Claude (free tier)
- Your terminal
- All OpenClaw skills (including the youtube-monetizer we built for your real money system)

Everything runs locally on your Chromebook.

## 1. One-time Setup on Chromebook

```bash
# Enable Linux if you haven't already (Settings > Advanced > Developers)

sudo apt update
sudo apt install python3-pip

pip3 install python-telegram-bot google-generativeai anthropic
```

## 2. Get Free API Keys

1. **Gemini** (recommended - very generous free tier):
   - Go to https://aistudio.google.com/app/apikey
   - Create key → copy it

2. **Claude** (free tier):
   - https://console.anthropic.com/
   - Create API key (you get free credits monthly)

3. **Grok** (optional - if you want it in the bot too):
   - https://console.x.ai/
   - Get API key

4. **Telegram Bot**:
   - Message @BotFather on Telegram
   - `/newbot` → give it a name (e.g. "SuperGrok5LUVINC")
   - Copy the token it gives you

## 3. Configure the Bot

Edit the script:

```bash
cd projects/OpenClaw/skills/youtube-monetizer/scripts
nano unified_telegram_bot.py
```

At the top, replace:

- `TELEGRAM_BOT_TOKEN`
- `GEMINI_API_KEY`
- `CLAUDE_API_KEY`
- (Optional) `GROK_API_KEY`

Also update `OPENCLAW_SKILLS_PATH` if needed (default should work).

## 4. Run It

```bash
python3 unified_telegram_bot.py
```

Keep the terminal open (or run with `nohup` or `screen`/`tmux` so it stays running).

Talk to your bot on Telegram using the commands in the script.

## Recommended Daily Usage for Your 5LUVINC Money System

- Normal messages → Gemini (fast + free)
- Long scripts or careful thinking → `/claude`
- Creative/strategy → `/grok` or just talk to me here
- Run your actual Python pipeline → `/terminal python3 ...` or `/openclaw youtube-monetizer`
- Real money tasks → Use the bot to trigger the pipeline we built

This is now your single free command center that ties Grok + Gemini + Claude + your custom OpenClaw tools + terminal together.

All for free. All running on your Chromebook. All routing money to your real accounts.

See the main SKILL.md for more usage ideas.
