# query-registry.lobster
# Allows any Lobster workflow or agent to query the Master Device (team-registry.json + MASTER_DEVICE.md)
# so the entire AI team always "knows all the users" — including current state of Claude's external master device.

name: query-registry
description: Query the Master Device / Team Registry for information about team members, capabilities, handoffs, or external coordination.

inputs:
  - name: query_type   # "list", "role", "name", "communication"
  - name: filter_value # e.g. "AI", "Claude", "Telegram"

steps:
  - id: run_query
    instruction: |
      Run the following command in the team-room directory:
      python3 scripts/who-is-on-the-team.py --{{ query_type }} "{{ filter_value }}" --roster

      This will output the relevant team members from the Master Device (v1.1+).
      The registry includes: capabilities matrix, handoff protocols, notification preferences, memory model, and external_master_devices (Claude Canon Core sync status).

  - id: post_to_room
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Master Device"
      message: "Registry query result for {{ query_type }} = {{ filter_value }}. All users known. External Claude master device coordination status included in full JSON."
      tags: "registry,query,master-device"
