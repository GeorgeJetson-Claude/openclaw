# full-launch-campaign.lobster
# VHS master workflow — coordinates the entire marketing push for an episode

name: full-launch-campaign
description: End-to-end marketing campaign builder for an Orbital Pioneers episode launch (Shorts, ads, social, merch, thumbnails).

inputs:
  - name: episode
  - name: launch_date

steps:
  - id: kickoff
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#launch"
      author: "VHS"
      message: "Starting full launch campaign build for {{ episode }}. Targeting {{ launch_date }}. Locking in hooks, assets, and calendar now."
      tags: "campaign,{{ episode }}"

  - id: run_shorts
    command: openclaw.invoke --workflow orbital-promo/create-youtube-shorts.lobster
    args:
      episode: $episode

  - id: run_thumbnails
    command: openclaw.invoke --workflow orbital-promo/thumbnail-factory.lobster
    args:
      episode: $episode
      focus: "main_episode"

  - id: build_social_calendar
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        You are VHS. Build a 7-day launch social calendar for {{ episode }}.
        Include Twitter/X, Instagram, TikTok, and YouTube Community posts.
        Heavy 90s nostalgia + family energy. Schedule with specific days and times.

  - id: ad_concepts
    command: openclaw.invoke --workflow orbital-promo/ad-video-concepts.lobster
    args:
      episode: $episode

  - id: merch_assets
    command: openclaw.invoke --workflow orbital-pioneers/merch-asset-generation.lobster
    args:
      episode: $episode

  - id: final_brief
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "VHS"
      message: |
        **{{ episode }} Launch Campaign COMPLETE**
        - 6 Shorts packages
        - 12+ thumbnail concepts + variations
        - 7-day social calendar
        - Paid ad concepts + scripts
        - Merch creative
        All assets in Drive under Orbital_Pioneers/Marketing/{{ episode }}/
        Ready for George to finalize video cuts and for paid traffic tests.
      tags: "campaign,launch,{{ episode }}"

  - id: done
    command: echo "VHS full launch campaign delivered for {{ episode }}."