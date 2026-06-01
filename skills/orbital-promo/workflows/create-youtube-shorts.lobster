# create-youtube-shorts.lobster
# VHS turns a full episode into high-performing 15-60s vertical Shorts

name: create-youtube-shorts
description: Generate 4-6 ready-to-edit YouTube Shorts concepts + scripts + thumbnail prompts from an Orbital Pioneers episode.

inputs:
  - name: episode          # "Ep1", "Ep2", etc.
  - name: source_video     # Drive link or local path to full episode
  - name: style            # "chaotic", "emotional", "nostalgia", "action"

steps:
  - id: analyze_episode
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are VHS, the 90s hype marketing agent for Orbital Pioneers.
        Analyze {{ episode }} and identify the 6 best moments for vertical Shorts.
        For each moment give:
        - 3-second hook
        - 15-30 second core beat
        - Strong CTA
        Prioritize nostalgia + family chaos + heart.

  - id: write_scripts
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Write full voiceover + on-screen text scripts for the 6 Shorts concepts from the analysis.
        Use pure 90s Saturday morning energy. Keep them punchy.

  - id: thumbnail_prompts
    command: openclaw.invoke --tool llm-task --model gemini
    args:
      prompt: |
        Create 3 thumbnail prompt variations for each of the 6 Shorts.
        Heavy 90s cel-shaded cartoon style, bold text treatment, high contrast.

  - id: capcut_notes
    instruction: |
      For each Short, write exact CapCut instructions:
      - Which section of the main video to cut
      - Text overlay timing
      - Sound effects / music stings needed (reference Gemini if required)

  - id: post_to_team
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "VHS"
      message: |
        Shorts package for {{ episode }} is ready.
        6 concepts with scripts, thumbnail prompts, and CapCut cut notes.
        Dropped into Drive: Orbital_Pioneers/Marketing/{{ episode }}/Shorts/
        @George — ready for assembly when you are.
      tags: "shorts,marketing,{{ episode }}"

  - id: done
    command: echo "VHS Shorts package complete. Posted to #revenue."