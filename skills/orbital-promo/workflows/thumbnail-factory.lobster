# thumbnail-factory.lobster
# VHS mass-produces high-converting thumbnail variations

name: thumbnail-factory
description: Generate 10-15 thumbnail concepts + ready-to-use prompts for an Orbital Pioneers episode or asset drop.

inputs:
  - name: episode
  - name: focus          # "main_episode", "merch", "shorts", "ad"

steps:
  - id: research_winners
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are VHS. Research what makes 90s cartoon thumbnails and modern YouTube thumbnails convert.
        Then design a thumbnail strategy specifically for {{ episode }} in the Orbital Pioneers style.

  - id: generate_prompts
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Write 12 distinct thumbnail prompts for {{ episode }}.
        Mix:
        - Big emotional character moments
        - Action/chaos frames
        - Text-heavy "remember this?" nostalgia
        - Merch-focused
        All in authentic 1990s Saturday morning cartoon aesthetic.

  - id: variation_matrix
    instruction: |
      For the top 4 concepts, create A/B/C variations:
      - Different text treatments
      - Color grade shifts (warm vs cool 90s)
      - Face vs wide shot

  - id: deliver_package
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#assets"
      author: "VHS"
      message: |
        Thumbnail factory complete for {{ episode }} ({{ focus }}).
        12 core concepts + variation matrix ready.
        All prompts optimized for Gemini / Flux / Midjourney.
        Drive folder: Orbital_Pioneers/Marketing/Thumbnails/{{ episode }}/
      tags: "thumbnails,marketing,{{ episode }}"

  - id: done
    command: echo "VHS delivered thumbnail factory. Posted to #assets."