# render-episode.lobster
# Reel's core workflow — turns assets into finished cartoon episodes + YouTube + site deployment

name: render-episode
description: Takes script, voiceover, SFX, music, and visuals and produces finished episodes (short or up to 20 minutes), YouTube uploads, ad packages, and website deployment.

inputs:
  - name: episode
  - name: target_runtime     # e.g. "75 seconds" or "20 minutes"
  - name: priority           # "ship fast", "max quality", "ads ready first", etc.

steps:
  - id: read_drive_briefing
    instruction: |
      MANDATORY FIRST STEP:
      Read the latest project state from Drive using:
      skills/orbital-pioneers/references/agent-drive-briefing.md
      Especially the Universe Bible, current episode status, ownership rules, and latest Team Room decisions.

  - id: prepare_assets
    instruction: |
      Gather and organize all assets for {{ episode }}:
      - Final timed script + voiceover files
      - SFX and music tracks
      - Visual panels / animation layers
      - Any reference boards

  - id: build_timeline
    command: openclaw.invoke --tool llm-task --model gemini
    args:
      prompt: |
        You are Reel, the video creator agent.
        Create a detailed step-by-step assembly plan for {{ episode }} in DaVinci Resolve or CapCut.
        Target runtime: {{ target_runtime }}.
        Use 90s cartoon style, smart limited animation, and strong pacing.
        Include exact timing, transitions, text, and SFX placement.

  - id: render_and_export
    instruction: |
      Execute the assembly plan.
      Render two versions:
      - 9:16 vertical (optimized for YouTube Shorts + mobile)
      - 16:9 horizontal (for website player)
      Prioritize speed while maintaining charm.

  - id: youtube_package
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Create full YouTube upload package for {{ episode }}:
        - 5 title options
        - Full description with timestamps and links
        - Tags
        - Thumbnail concepts
        - End screen + card strategy
        - YouTube ad creative briefs (3 versions)

  - id: prepare_ads
    instruction: |
      Finalize ad creative and submit for YouTube approval.
      Include the 3 ad versions from the previous step.

  - id: deploy_to_site
    instruction: |
      Upload the finished horizontal version to Google Drive (public link).
      Update the custom 90s player on all websites with the new episode.
      Generate deployment confirmation for the team.

  - id: handoff_to_team
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#launch"
      author: "Reel"
      message: |
        Episode {{ episode }} render complete.

        - Finished files ready (vertical + horizontal)
        - YouTube upload package + ads submitted for approval
        - Live on the website player

        George: Final polish file attached if needed.
        VHS: Marketing assets from this render available.
        Banker: Revenue angles from this episode attached.
      tags: "episode,render,{{ episode }}"

  - id: done
    command: echo "Reel has delivered the finished episode, YouTube package, and site deployment."