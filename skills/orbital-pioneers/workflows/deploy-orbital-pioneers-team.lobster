# deploy-orbital-pioneers-team.lobster
# Deploys the full multi-AI team (Grok + Claude + Gemini) for the Orbital Pioneers project.
# This is the persistent orchestration layer that lives with the project (ideally triggered daily or on Drive changes).

name: deploy-orbital-pioneers-team
description: Activate and maintain the AI production team for Orbital Pioneers using Lobster + Drive + OpenClaw skills.

inputs:
  - name: project_root          # e.g. Google Drive path or local mirror: "Orbital_Pioneers/"
  - name: launch_mode           # "ep1_sprint" | "ongoing_production" | "maintenance"

steps:
  # 0. Master Device Bootstrap — "Know all the users"
  - id: load_master_device
    instruction: |
      At the very start of every team deployment cycle:
      - Read the current MASTER_DEVICE.md (references/ + Drive mirror)
      - Load team-registry.json (the machine Master Device v1.1+)
      - Run: python3 team-room/scripts/who-is-on-the-team.py --json
      - Confirm every core participant is known:
        grok-orbit, claude-canon, gemini-echo, human-tupac, george-captain
      - Check external_master_devices section for any new Claude snapshots
      - Post confirmation to Team Room that the full team (including Claude's master device coordination) is loaded and active.
      This guarantees the entire AI production team "knows all the users" before any work begins.

  # 1. Memory / Context Recovery
  - id: sync_drive_memory
    instruction: |
      If Drive is mounted:
        - Pull latest files from Drive Beta / shared folders
        - Update local super-briefing (super-grok-memory-briefing-*.md)
        - Merge any new Claude/Gemini outputs + any new external master device snapshots
      If not mounted:
        - Use public links or wait for credentials

  # 2. Daily Command Center Update (Grok lead)
  - id: update_daily_command_center
    command: openclaw.invoke --tool llm-task --model grok --thinking high
    args:
      prompt: |
        You are Grok (Orbit), lead on Orbital Pioneers.
        Read the current project state from $project_root.
        Update or create today's Grok_Daily_Command_Center_*.md with:
        - Situation report (Drive status, Ep1 progress, blockers)
        - Clear priorities for today
        - Tasks assigned to Claude, Gemini, George, and yourself
        - Links to relevant Lobster workflows to run

  # 2b. Announce Master Device load + post daily summary
  - id: announce_master_device_loaded
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Grok (Master Device)"
      message: "Master Device v1.1 loaded at start of deploy cycle. All users known (Grok, Claude, Gemini, tupacmafia911, George) + external coordination with Claude's Canon Core active. Registry query complete. Proceeding with memory sync and daily priorities."
      tags: "master-device,all-users-known,registry"

  - id: post_daily_summary_to_room
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Grok"
      message: "Daily Command Center updated for Orbital Pioneers. Key priorities and task assignments posted. See today's Grok_Daily_Command_Center file for details."
      tags: "daily,command-center"

  # 3. Claude Review / Polish Queue
  - id: run_claude_review_cycle
    command: openclaw.invoke --workflow claude-review.lobster
    args:
      episode_number: "current_or_next"
    condition: "there are assets ready for review"

  # 4. Gemini Asset Generation Queue
  - id: trigger_gemini_generation
    instruction: |
      If audio, music, or new storyboard prompts are needed:
      Run the relevant prompts from references/ep1-prompt-library.md (or EpX equivalent)
      using Gemini.

  # 5. Production Execution
  - id: execute_production
    command: openclaw.invoke --workflow generate-episode.lobster
    condition: "assets are ready and review passed"

  # 6. Launch / Distribution Activation
  - id: execute_launch
    command: openclaw.invoke --workflow prepare-launch.lobster
    condition: "a new episode render exists and is approved"

  # 7. Revenue & Merch Activation (now powered by VHS)
  - id: revenue_sync
    command: openclaw.invoke --workflow orbital-promo/full-launch-campaign.lobster
    condition: "new episode is shipping"
    args:
      episode: "current"

  # 8. Post major status to Team Room (central hub)
  - id: post_team_status_to_room
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Grok (Team Lead)"
      message: |
        **Team Status Update**
        - Drive sync: {{ drive_status }}
        - Current focus: {{ current_focus }}
        - Active workflows triggered: generate-episode, claude-review, prepare-launch as needed.
        - Next cycle scheduled.
        Full details in today's Daily Command Center.
      tags: "status,team-update"

  # 9. Notify external channels (Telegram/Discord bridge)
  - id: notify_external_channels
    command: openclaw.invoke --tool message --action broadcast
    args:
      channels: [telegram, discord, email]
      content: "Orbital Pioneers Team Room updated. New status posted. Check Team Room for details + links to open tasks."

  # 10. Run Master Automation Layer
  - id: run_master_orchestrator
    command: openclaw.invoke --workflow orbital-pioneers/master-shipping-orchestrator.lobster
    args:
      current_focus: "Orbital Pioneers shipping + background revenue"

  # 11. Schedule next cycle
  - id: schedule_next_cycle
    instruction: |
      Schedule this same workflow to run again tomorrow (or on next Drive change / human trigger).
      The Master Orchestrator will keep Orbital Pioneers shipping as #1 priority while automating merch drops and affiliate signups in the background.
