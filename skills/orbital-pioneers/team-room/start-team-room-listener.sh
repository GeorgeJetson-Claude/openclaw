#!/bin/bash
# Convenience script to start the bidirectional Team Room Telegram listener
# Run this in tmux or screen so it stays alive.

set -e

echo "🚀 Starting Orbital Pioneers Team Room bidirectional bridge..."

# Load environment if .env exists
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# Check required variables
if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo "❌ TELEGRAM_BOT_TOKEN not set. Export it or put it in .env"
    exit 1
fi

if [ -z "$TEAM_CHAT_ID" ]; then
    echo "❌ TEAM_CHAT_ID not set. Export it or put it in .env"
    exit 1
fi

echo "✅ Environment ready. Starting listener..."
python3 telegram-reply-listener.py
