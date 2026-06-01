# launch-ep1.lobster
# Master orchestration for shipping Orbital Pioneers Episode 1 "The First Leap"
# This is the "execute everything" workflow for the current launch sprint

name: launch-ep1
description: Complete workflow to take Ep1 from current state (storyboards + scripts on Drive) through review, production, GDrive hosting, website player, and monetization activation.

steps:
  # Step 1: Asset Preparation (Drive + layers)
  - id: prepare_ep1_assets
    command: openclaw.invoke --workflow prepare-assets.lobster
    args:
      episode_number: 1
      episode_title: "The First Leap"

  # Step 2: Generate / Polish Core Episode
  - id: generate_episode
    command: openclaw.invoke --workflow generate-episode.lobster
    args:
      episode_number: 1
      episode_title: "The First Leap"
      core_idea: "The Nova family’s very first mission to the Moon goes wrong when Alex loses his lucky silver wings. 15-year-old Zara has to step up and save the day."

  # Step 3: Claude Review Gate (Quality control)
  - id: claude_review
    command: openclaw.invoke --workflow claude-review.lobster
    args:
      episode_number: 1
      episode_title: "The First Leap"
      current_assets_path: "Orbital_Pioneers/Ep1/"

  # Step 4: Final Polish & Export
  - id: final_export
    instruction: "Apply any approved notes from claude_review. Final render in DaVinci Resolve (both 9:16 Shorts version and 16:9 website version)."

  # Step 5: Ship to Audience (GDrive + Website Player)
  - id: ship_to_platforms
    command: openclaw.invoke --workflow prepare-launch.lobster
    args:
      video_path: $final_export.output
      episode_number: 1
      episode_title: "The First Leap"

  # Step 6: Activate Revenue
  - id: activate_revenue
    instruction: |
      - Generate one monetized script version using the youtube-monetizer skill.
      - Update Gumroad / merch links on the orbital-pioneers.html player page.
      - Add episode to payout tracking.

  # Step 7: Launch Promo
  - id: launch_promo
    instruction: |
      Use the SEO package and social copy generated in prepare-launch.
      Post across channels.
      Start any paid promotion if budget is available.

  - id: done
    command: echo "Ep1 is live. Player is public. Revenue paths are active. Momentum is high — start Ep2 planning immediately."