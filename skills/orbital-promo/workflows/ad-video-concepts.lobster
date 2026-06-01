# ad-video-concepts.lobster
# VHS creates 15-30 second ad concepts optimized for paid traffic

name: ad-video-concepts
description: Generate 5-7 paid ad video concepts (script + visual direction + platform targeting) for an episode.

inputs:
  - name: episode

steps:
  - id: platform_strategy
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are VHS. For {{ episode }}, design ad concepts for Meta (Instagram/Facebook), YouTube, and TikTok.
        Different hooks per platform.

  - id: write_concepts
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Write 6 complete 15-30 second ad scripts for {{ episode }}.
        Each one optimized for a different platform + audience segment (nostalgia parents, AI fans, space nerds, families).

  - id: visual_direction
    instruction: |
      For each concept, write exact visual direction + text on screen + music/SFX notes.

  - id: deliver
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "VHS"
      message: "Paid ad video concepts for {{ episode }} ready. 6 scripts with platform-specific hooks and full visual direction."
      tags: "ads,paid,{{ episode }}"

  - id: done
    command: echo "Ad concepts delivered."