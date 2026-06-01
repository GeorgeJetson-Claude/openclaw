#!/usr/bin/env python3
"""
Bidirectional Bridge Listener for Orbital Pioneers Team Room

This script listens to your Telegram team chat.
When someone replies to a message that came from the Team Room,
it automatically posts the reply back into TEAM_ROOM.md
(using the post-to-team-room.lobster workflow).

This creates true "talk in and out" for the full AI team (Grok + Claude + Gemini + Human).

Requirements:
- python-telegram-bot (pip install python-telegram-bot)
- The same Telegram bot token you already use for the monetizer skill
- The post-to-team-room.lobster workflow available in your OpenClaw installation

Run this 24/7 (recommended: tmux, systemd, or a cheap VPS) for seamless communication.

Usage:
    export TELEGRAM_BOT_TOKEN="your-bot-token"
    export TEAM_CHAT_ID="-1001234567890"   # Your team group/supergroup ID
    python3 telegram-reply-listener.py
"""

import os
import subprocess
from telegram import Update
from telegram.ext import ApplicationBuilder, MessageHandler, filters, ContextTypes

# === CONFIGURATION ===
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")  # Use the same bot as your other tools
TEAM_CHAT_ID = os.getenv("TEAM_CHAT_ID")              # The group/supergroup where the team talks
TEAM_ROOM_PATH = "skills/orbital-pioneers/team-room/TEAM_ROOM.md"  # Relative or absolute

# Keywords that identify messages originating from the Team Room
TEAM_ROOM_KEYWORDS = ["Team Room", "orbital-pioneers", "#production", "#review", "#launch"]

async def handle_reply(update: Update, context: ContextTypes.DEFAULT_TYPE):
    message = update.message

    # Only process replies
    if not message.reply_to_message:
        return

    original_text = message.reply_to_message.text or ""
    reply_text = message.text or ""
    author = message.from_user.first_name or "Human"

    # Check if the original message was a Team Room notification
    is_team_room_message = any(keyword.lower() in original_text.lower() for keyword in TEAM_ROOM_KEYWORDS)

    if is_team_room_message and reply_text.strip():
        print(f"[Bridge] Detected reply from {author}: {reply_text[:80]}...")

        # Smarter channel detection from the replied message
        channel = "#general"
        known_channels = ["#production", "#review", "#launch", "#revenue", "#assets", "#ai-handoff", "#daily-briefings", "#drive-assets", "#general"]
        for kw in known_channels:
            if kw in original_text:
                channel = kw
                break

        # Also try to extract channel if the bot message contained "in #channel"
        import re
        channel_match = re.search(r'in (#[\w-]+)', original_text)
        if channel_match:
            channel = channel_match.group(1)

        # Call the Lobster post workflow to append to the Team Room
        try:
            cmd = [
                "openclaw", "taskflow", "run",
                "skills/orbital-pioneers/team-room/post-to-team-room.lobster",
                "--input", f"channel={channel}",
                "--input", f"author=Human (via Telegram - {author})",
                "--input", f"message={reply_text}",
                "--input", "tags=telegram-reply"
            ]
            subprocess.run(cmd, check=True)
            print(f"[Bridge] Successfully posted reply from {author} to Team Room (channel: {channel})")
        except Exception as e:
            print(f"[Bridge] Error posting reply: {e}")


def main():
    if not TELEGRAM_BOT_TOKEN or not TEAM_CHAT_ID:
        print("ERROR: Set TELEGRAM_BOT_TOKEN and TEAM_CHAT_ID environment variables.")
        return

    app = ApplicationBuilder().token(TELEGRAM_BOT_TOKEN).build()

    # Listen for any message that is a reply in the team chat
    app.add_handler(MessageHandler(
        filters.Chat(chat_id=int(TEAM_CHAT_ID)) & filters.REPLY,
        handle_reply
    ))

    print("Orbital Pioneers Team Room Telegram bridge listener is running...")
    print("Replies in the team chat will be automatically posted back to the Team Room.")
    app.run_polling()


if __name__ == "__main__":
    main()
