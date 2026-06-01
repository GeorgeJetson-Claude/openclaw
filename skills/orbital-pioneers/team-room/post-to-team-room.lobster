# post-to-team-room.lobster
# Allows any AI (or human via script) to post a clean, dated update to the shared Team Room

name: post-to-team-room
description: Append a formatted message to the central Orbital Pioneers Team Room.

inputs:
  - name: channel        # e.g. "#production", "#review", "#general"
  - name: author         # e.g. "Grok", "Claude", "Gemini", "Human"
  - name: message        # The actual content
  - name: tags           # Optional: comma-separated tags like "Ep1,urgent"

steps:
  - id: format_entry
    command: openclaw.invoke --tool template-render
    args:
      template: |
        ### {{ date }} — {{ author }}
        **Channel:** {{ channel }}
        {% if tags %}**Tags:** {{ tags }}{% endif %}

        {{ message }}

        ---
    inputs:
      date: "$(date '+%Y-%m-%d %H:%M')"
      author: $author
      channel: $channel
      message: $message
      tags: $tags

  - id: append_to_room
    instruction: |
      Append the formatted entry to the end of:
      Orbital_Pioneers/Team_Room/TEAM_ROOM.md
      (or the local mirror)

  - id: notify_external_bridge
    instruction: |
      Forward a short version of this post to configured external channels (Telegram, Discord) using the existing message tool.
      This creates the "in and out" bridge so the Team Room is the source of truth, but humans get notified on their preferred apps.

  - id: done
    command: echo "Message posted to Team Room by {{ author }} in {{ channel }} and bridged to external channels."
