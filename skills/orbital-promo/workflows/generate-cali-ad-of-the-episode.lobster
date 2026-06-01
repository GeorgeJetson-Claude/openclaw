# generate-cali-ad-of-the-episode.lobster
# VHS + Grok generate the perfect Cali ad for the current episode

name: generate-cali-ad-of-the-episode
description: Creates 3 tailored Cali advertisement concepts + full scripts + image prompts for a specific Orbital Pioneers episode. Optimized for Gumroad merch tie-ins.

inputs:
  - name: episode          # "Ep1", "Ep2", etc.
  - name: vibe             # "chaos", "emotional", "villain", "nostalgia", "random"

steps:
  - id: analyze_episode
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are VHS, the 90s marketing agent.
        Analyze {{ episode }} and find the best emotional, chaotic, or villain-related moments.
        Then create 3 perfect Cali ad concepts that would feel funny playing in the background during those moments.

  - id: write_scripts
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Write 3 complete 15-30 second commercial scripts for the Cali ads from the previous analysis.
        Use pure 90s cartoon announcer energy. Make them sellable on Gumroad.

  - id: generate_prompts
    command: openclaw.invoke --tool llm-task --model gemini
    args:
      prompt: |
        Create detailed image generation prompts (for Gemini/Flux) for each of the 3 ads.
        Include style notes for 90s cartoon aesthetic.

  - id: merch_suggestions
    instruction: |
      For each ad, suggest 1-2 Gumroad product ideas that could come from it (stickers, shirts, digital packs).

  - id: post_to_team
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "VHS"
      message: |
        Cali Ad of the Episode package for {{ episode }} is ready.
        3 concepts + full scripts + image prompts + Gumroad product suggestions.
        Posted to Drive: Orbital_Pioneers/Marketing/Cali_Ads/{{ episode }}/
        @team — which one should we push hardest this week?
      tags: "cali,ads,{{ episode }},gumroad"

  - id: done
    command: echo "Cali Ad of the Episode generated and posted to #revenue."