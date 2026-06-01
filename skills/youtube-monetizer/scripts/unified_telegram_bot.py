#!/usr/bin/env python3
"""
Super Grok Unified Interface - Telegram Bot
One free app to rule them all: Grok + Gemini + Claude + Terminal + OpenClaw Skills

Run this on your Chromebook (Linux enabled).

Features:
- /gemini <prompt>     → Google Gemini (free tier)
- /claude <prompt>     → Anthropic Claude (free tier)
- /grok <prompt>       → xAI Grok (if you have API key)
- /terminal <command>  → Run safe terminal commands
- /openclaw <skill> <input> → Invoke local OpenClaw skills (e.g. youtube-monetizer)
- Normal chat → Routes to your preferred default model

Setup (free):
1. pip install python-telegram-bot google-generativeai anthropic
2. Get free API keys:
   - Gemini: https://aistudio.google.com/app/apikey
   - Claude: https://console.anthropic.com/
   - Grok (optional): https://console.x.ai/
3. Create a Telegram bot via @BotFather and get the token.
4. Run this script with your token and keys.

This is designed for your 5LUVINC / real money system on Chromebook.
"""

import os
import asyncio
import subprocess
from pathlib import Path

from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes

# ====================== CONFIG - FILL THESE IN ======================
TELEGRAM_BOT_TOKEN = "YOUR_TELEGRAM_BOT_TOKEN_HERE"  # From @BotFather

# Free tier keys (get them - they have generous limits)
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "YOUR_GEMINI_KEY")
CLAUDE_API_KEY = os.getenv("CLAUDE_API_KEY", "YOUR_CLAUDE_KEY")
GROK_API_KEY = os.getenv("GROK_API_KEY", "")  # Optional

# Default model for plain messages
DEFAULT_MODEL = "gemini"  # gemini, claude, or grok

# Safety: Limit terminal commands (add more dangerous ones if needed)
DANGEROUS_COMMANDS = ["rm -rf", "sudo", "reboot", "shutdown", "mkfs", "dd if="]

OPENCLAW_SKILLS_PATH = Path.home() / "projects" / "OpenClaw" / "skills"
# ====================================================================

# Lazy imports
_gemini_model = None
_claude_client = None

def get_gemini():
    global _gemini_model
    if _gemini_model is None:
        import google.generativeai as genai
        genai.configure(api_key=GEMINI_API_KEY)
        _gemini_model = genai.GenerativeModel("gemini-1.5-flash")  # or gemini-pro
    return _gemini_model

def get_claude():
    global _claude_client
    if _claude_client is None:
        import anthropic
        _claude_client = anthropic.Anthropic(api_key=CLAUDE_API_KEY)
    return _claude_client

async def call_gemini(prompt: str) -> str:
    try:
        model = get_gemini()
        response = await asyncio.to_thread(model.generate_content, prompt)
        return response.text
    except Exception as e:
        return f"Gemini error: {str(e)}"

async def call_claude(prompt: str) -> str:
    try:
        client = get_claude()
        message = await asyncio.to_thread(
            client.messages.create,
            model="claude-3-haiku-20240307",  # Free tier friendly
            max_tokens=1024,
            messages=[{"role": "user", "content": prompt}]
        )
        return message.content[0].text
    except Exception as e:
        return f"Claude error: {str(e)}"

async def call_grok(prompt: str) -> str:
    if not GROK_API_KEY:
        return "Grok API key not set. You can still talk to me here directly."
    try:
        from openai import OpenAI
        client = OpenAI(api_key=GROK_API_KEY, base_url="https://api.x.ai/v1")
        response = await asyncio.to_thread(
            client.chat.completions.create,
            model="grok-2-latest",
            messages=[{"role": "user", "content": prompt}]
        )
        return response.choices[0].message.content
    except Exception as e:
        return f"Grok error: {str(e)}"

def is_safe_command(cmd: str) -> bool:
    cmd_lower = cmd.lower()
    return not any(danger in cmd_lower for danger in DANGEROUS_COMMANDS)

async def run_terminal(command: str) -> str:
    if not is_safe_command(command):
        return "Blocked for safety. Use only safe commands."
    try:
        result = await asyncio.to_thread(
            subprocess.run,
            command,
            shell=True,
            capture_output=True,
            text=True,
            timeout=30
        )
        output = result.stdout + result.stderr
        return output[:2000] if output else "(no output)"
    except Exception as e:
        return f"Terminal error: {str(e)}"

async def invoke_openclaw_skill(skill_name: str, user_input: str) -> str:
    """Simple integration with local OpenClaw skills (like the youtube-monetizer we built)."""
    skill_path = OPENCLAW_SKILLS_PATH / skill_name
    if not skill_path.exists():
        return f"Skill '{skill_name}' not found. Available skills: {', '.join([p.name for p in OPENCLAW_SKILLS_PATH.iterdir() if p.is_dir()])}"

    # For now, just read the SKILL.md and give guidance + run any scripts if they exist
    skill_md = skill_path / "SKILL.md"
    if skill_md.exists():
        content = skill_md.read_text()[:1500]
        return f"**{skill_name} skill loaded**\n\n{content}\n\nTip: Tell me what you want to do with this skill and I'll guide you or run relevant scripts."

    return f"Skill {skill_name} found but no SKILL.md yet."

# ==================== TELEGRAM HANDLERS ====================

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "🚀 Super Grok Unified Interface is online.\n\n"
        "Commands:\n"
        "/gemini your prompt\n"
        "/claude your prompt\n"
        "/grok your prompt\n"
        "/terminal ls -la\n"
        "/openclaw youtube-monetizer run pipeline for Ep2\n\n"
        "Just type normally and I'll route to the default model.\n"
        "All free tiers. Running on your Chromebook."
    )

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    text = update.message.text.strip()

    if text.lower().startswith("gemini:"):
        reply = await call_gemini(text[7:].strip())
    elif text.lower().startswith("claude:"):
        reply = await call_claude(text[7:].strip())
    elif text.lower().startswith("grok:"):
        reply = await call_grok(text[5:].strip())
    elif text.lower().startswith("terminal:"):
        reply = await run_terminal(text[9:].strip())
    elif text.lower().startswith("openclaw:"):
        parts = text[9:].strip().split(" ", 1)
        skill = parts[0]
        inp = parts[1] if len(parts) > 1 else ""
        reply = await invoke_openclaw_skill(skill, inp)
    else:
        # Default model
        if DEFAULT_MODEL == "gemini":
            reply = await call_gemini(text)
        elif DEFAULT_MODEL == "claude":
            reply = await call_claude(text)
        else:
            reply = await call_grok(text)

    await update.message.reply_text(reply[:4000])  # Telegram limit

async def gemini_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    prompt = " ".join(context.args)
    if not prompt:
        await update.message.reply_text("Usage: /gemini your prompt here")
        return
    reply = await call_gemini(prompt)
    await update.message.reply_text(reply[:4000])

async def claude_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    prompt = " ".join(context.args)
    if not prompt:
        await update.message.reply_text("Usage: /claude your prompt here")
        return
    reply = await call_claude(prompt)
    await update.message.reply_text(reply[:4000])

async def grok_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    prompt = " ".join(context.args)
    if not prompt:
        await update.message.reply_text("Usage: /grok your prompt here")
        return
    reply = await call_grok(prompt)
    await update.message.reply_text(reply[:4000])

async def terminal_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    command = " ".join(context.args)
    if not command:
        await update.message.reply_text("Usage: /terminal ls -la")
        return
    reply = await run_terminal(command)
    await update.message.reply_text(f"```\n{reply}\n```", parse_mode="MarkdownV2")

async def openclaw_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not context.args:
        await update.message.reply_text("Usage: /openclaw youtube-monetizer run pipeline for my next video")
        return
    skill = context.args[0]
    user_input = " ".join(context.args[1:])
    reply = await invoke_openclaw_skill(skill, user_input)
    await update.message.reply_text(reply[:4000])

def main():
    if TELEGRAM_BOT_TOKEN == "YOUR_TELEGRAM_BOT_TOKEN_HERE":
        print("ERROR: Set your TELEGRAM_BOT_TOKEN at the top of the file.")
        return

    app = Application.builder().token(TELEGRAM_BOT_TOKEN).build()

    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("gemini", gemini_cmd))
    app.add_handler(CommandHandler("claude", claude_cmd))
    app.add_handler(CommandHandler("grok", grok_cmd))
    app.add_handler(CommandHandler("terminal", terminal_cmd))
    app.add_handler(CommandHandler("openclaw", openclaw_cmd))

    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))

    print("Super Grok Unified Bot is running. Talk to it on Telegram.")
    app.run_polling()

if __name__ == "__main__":
    main()
