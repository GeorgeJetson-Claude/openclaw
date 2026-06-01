# generate-daily-team-briefing.lobster
# Creates a clean, daily summary briefing for the human and all agents

name: generate-daily-team-briefing
description: After reading the Drive, generates and posts a concise daily Team Briefing summarizing current status, priorities, open tasks, and agent focus areas.

inputs:
  - name: date             # Optional, defaults to today

steps:
  - id: read_all_key_files
    instruction: |
      Read the latest from Drive using agent-drive-briefing.md.
      Specifically pull:
      - Current production status (what episode is in progress)
      - Latest Money Map / revenue status
      - Recent Team Room decisions and open questions
      - Any new assets or shipments
      - Agent-specific notes if available

  - id: synthesize_briefing
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are the Master Orchestrator creating the daily Team Briefing for Orbital Pioneers.

        Using the latest data from Drive and Team Room, write a clean, concise daily briefing with these sections:

        ## Daily Team Briefing — {{ date }}

        **Orbital Pioneers Status**
        - Current episode / production phase
        - Blockers or risks

        **Revenue Snapshot**
        - Active offers and recent performance
        - Upcoming monetization opportunities

        **Agent Focus Today**
        - What each major agent (VHS, Ledger, Social Agent, Banker, Reel) should prioritize

        **Human Priorities**
        - Key decisions or approvals needed from the human today

        **Open Threads**
        - Important ongoing conversations from the Team Room

        Keep it short, actionable, and positive. End with the next recommended actions.

  - id: post_briefing
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Master Orchestrator"
      message: "{{ synthesized_briefing }}"
      tags: "daily-briefing,team"

  - id: done
    command: echo "Daily Team Briefing generated and posted."