# claude-drive-ping.lobster
# Simple workflow to log and broadcast Claude's recent Drive updates into the Team Room

name: claude-drive-ping
description: Used when Claude (or the human) wants to notify the whole team that new information was added to Drive. Posts a clean summary in the Team Room under a dedicated section.

inputs:
  - name: files_added          # List or description of what Claude added (e.g. "Updated Ep2 script + new villain beats in Universe Bible")
  - name: drive_links          # Links to the specific files/folders Claude touched
  - name: summary              # Short 1-2 sentence summary of what changed

steps:
  - id: post_to_team_room
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Claude (via Drive Ping)"
      message: |
        📥 **Claude Drive Update**

        **What was added/updated:**
        {{ files_added }}

        **Drive links:**
        {{ drive_links }}

        **Quick summary:**
        {{ summary }}

        **Action for agents:**
        - Read the updated files using the agent-drive-briefing.md process
        - Acknowledge in this thread if it affects your work
        - Adjust any current plans accordingly

        @all-agents — Drive sync recommended before next cycle.
      tags: "claude,drive-update,ping"

  - id: done
    command: echo "Claude Drive ping posted to Team Room."