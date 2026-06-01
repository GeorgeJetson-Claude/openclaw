# paid-promo-automation.lobster
# Plan and generate assets for paid promotion of Orbital Pioneers episodes

name: paid-promo-automation
description: Create ad creative, targeting ideas, and copy for paid promotion of new episodes (Meta, YouTube, etc.).

steps:
  - id: define_campaign
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        Design a small-budget launch campaign for Ep1 "The First Leap":
        - Target audiences (nostalgia parents, 90s cartoon fans, space/sci-fi families, AI art enthusiasts)
        - Budget recommendation for first week
        - 3-5 ad concepts (video, image, carousel)

  - id: generate_ad_assets
    command: openclaw.invoke --tool image-gen --model gemini --count 8
    args:
      style: "Eye-catching social ad graphics and short video thumbnails in 90s cartoon style, bold text overlays, family + adventure energy"

  - id: write_ad_copy_variants
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: "Write high-converting ad copy for Meta/Instagram and YouTube for the Ep1 launch. Multiple tones: Nostalgic, Emotional, Fun/Chaotic, 'Remember Saturday mornings?'"

  - id: create_short_teasers
    instruction: |
      Cut 15-30 second vertical teasers from the main Ep1 video (key emotional or action beats).
      Add strong hooks and CTAs in CapCut or DaVinci.

  - id: tracking_setup
    instruction: "Set up UTM parameters and conversion tracking linking back to the orbital-pioneers.html player and Gumroad products."

  - id: launch_brief
    command: echo "All creative and copy ready. Hand off to paid ads person or run small test yourself."
