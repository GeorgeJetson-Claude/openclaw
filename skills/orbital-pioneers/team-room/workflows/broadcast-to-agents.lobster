# broadcast-to-agents.lobster
# Allows the human to broadcast a message to ALL agents at once via the Team Room

name: broadcast-to-agents
description: Human posts a message tagged @all-agents (or runs this workflow) and it gets delivered to every active agent with instructions to read the Drive first and respond if relevant.

inputs:
  - name: message          # The message from the human
  - name: context          # Optional extra context (e.g. "Urgent", "Planning for Ep2", "Revenue review")

steps:
  - id: read_latest_drive
    instruction: |
      Before processing, all agents receiving this must first read the latest from Drive using:
      skills/orbital-pioneers/references/agent-drive-briefing.md

  - id: deliver_to_agents
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Human (via Broadcast)"
      message: |
        📢 **@ALL AGENTS** — New broadcast from the human

        {{ message }}

        {% if context %}**Context:** {{ context }}{% endif %}

        **Instructions for all agents:**
        1. Immediately read the latest Drive state using `agent-drive-briefing.md`
        2. Acknowledge receipt in this thread if relevant to your role
        3. Take action or reply with your plan if this affects your work
        4. Tag the human or relevant agents when responding

        Agents: Orbit, VHS, Ledger, Social Agent, Banker (Bigo), Reel
      tags: "broadcast,all-agents,{{ context }}"

  - id: done
    command: echo "Broadcast delivered to all agents via Team Room."