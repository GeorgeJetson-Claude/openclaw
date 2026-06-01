# orchestrate-ep1-launch.lobster
# Master workflow for shipping Orbital Pioneers Episode 1
# Includes multi-AI review (especially Claude) + production + free distribution + monetization

name: orchestrate-ep1-launch
description: Full end-to-end launch of Ep1 "The First Leap" using free tools + Lobster orchestration + GDrive + website player.

steps:
  # 1. Creative & Script Phase (already done in practice)
  - id: generate_core_assets
    command: openclaw.invoke --workflow generate-episode.lobster
    args:
      episode_number: 1
      episode_title: "The First Leap"
      core_idea: "The Nova family’s very first mission to the Moon goes wrong when Alex loses his lucky wings. 15-year-old Zara has to step up."

  # 2. Human + Claude Review Gate (critical quality step)
  - id: claude_review_gate
    instruction: |
      PAUSE FOR HUMAN + CLAUDE REVIEW
      - Send latest render + script + visuals to Claude.
      - Ask for detailed review on: story clarity, 90s cartoon authenticity, emotional beats, pacing, character voices.
      - Claude returns notes.
      - Human (you) decides: Approve / Minor fixes / Major rework.
      Only proceed when this gate passes.

  # 3. Final Polish & Export
  - id: final_polish_and_export
    instruction: "Apply any accepted notes from claude_review_gate. Final render in DaVinci Resolve (both vertical and horizontal)."

  # 4. Distribution (Cheap GDrive + Website)
  - id: ship_to_audience
    command: openclaw.invoke --workflow prepare-launch.lobster
    inputs:
      video_path: $final_polish_and_export.output
      episode_number: 1
      episode_title: "The First Leap"

  # 5. Activate Revenue Engine
  - id: activate_monetization
    instruction: |
      - Use youtube-monetizer skill to generate one affiliate-heavy script version of Ep1.
      - Update Gumroad / merch links in the player page.
      - Log the episode in payout tracking.

  # 6. Promotion Kickoff
  - id: launch_promo
    instruction: |
      Use the SEO + social copy generated in prepare-launch.
      Post to all channels + start any paid boost.
      Pin the strong comment with Gumroad + "next episode" hook.

  - id: post_launch
    command: echo "Ep1 is live. Player is public. Revenue paths are active. Start Episode 2 planning immediately while momentum is hot."
