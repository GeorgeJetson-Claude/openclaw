# generate-episode.lobster
# Full free pipeline for Orbital Pioneers (90s cartoon)
# Orchestrates Grok + Claude + Gemini + free tools (DaVinci Resolve, Photopea, etc.)

name: generate-episode
description: End-to-end production of one Orbital Pioneers episode using only free tools + multi-AI team.

inputs:
  - name: episode_number
  - name: episode_title
  - name: core_idea

steps:
  # Phase 1: Creative Direction (Grok lead)
  - id: expand_concept
    command: openclaw.invoke --tool llm-task --model grok --thinking high
    args:
      prompt: "Expand the core idea into a full 90s cartoon episode concept with emotional hook, 3-act structure, 8 key visual moments, and character beats for the Nova family. Output structured JSON with title, logline, acts, and visual moments."
    inputs:
      core_idea: $core_idea

  # Phase 2: Script (Claude lead - user preference for dialogue)
  - id: write_timed_script
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: "Write a tight 75-90 second voiceover script in classic energetic 90s Saturday morning cartoon narrator style. Include character dialogue. Format with exact timing. Use the Nova family voice profiles."
    stdin: $expand_concept.stdout

  # Phase 3: Storyboards (Gemini image gen)
  - id: generate_8_panels
    command: openclaw.invoke --tool image-gen --model gemini --count 8
    args:
      style: "90s Saturday morning cartoon, bold black outlines, flat vibrant colors, dramatic lighting like Batman: The Animated Series, gritty but hopeful, family adventure"
    stdin: $write_timed_script.stdout

  # Phase 4: Asset Prep (Human + Photopea)
  - id: separate_layers_photopea
    instruction: |
      MANUAL STEP (or script later):
      Use Photopea (free) to separate each of the 8 panels into layers:
      - Background, Midground, Characters, Props, Effects
      Export as PNGs with transparency.
      Organize in Google Drive: Orbital_Pioneers/Ep{episode_number}/layers/

  # Phase 5: Audio Prompts (Gemini)
  - id: generate_audio_prompts
    command: openclaw.invoke --tool llm-task --model gemini
    args:
      prompt: "Create production-ready prompts for: main theme music, all SFX (thrusters, impacts, Echo beeps, alarms), and voice direction for Alex, Maya, Zara, Leo, Echo. Include timing notes."
    stdin: $write_timed_script.stdout

  # Phase 6: Animation & Edit (DaVinci Resolve - core free tool)
  - id: animate_and_edit
    instruction: |
      In DaVinci Resolve (free version):
      1. Import layered PNGs
      2. Apply: Ken Burns camera moves, parallax layers, subtle character breathing, VHS grain + 90s color grade
      3. Composite strictly to the timed script from step write_timed_script
      4. Add temp audio placeholders
      Export rough cut (both 9:16 and 16:9 versions)

  # Phase 7: Audio Production
  - id: produce_final_audio
    instruction: |
      Generate voices (ElevenLabs free tier or Gemini TTS) + SFX using prompts from step generate_audio_prompts.
      Mix in DaVinci Fairlight: music bed low, SFX, dialogue on top.
      Export final audio mix synced to picture.

  # Phase 8: Final Render
  - id: final_render
    instruction: |
      Final composite in DaVinci.
      Deliver:
      - 9:16 vertical (YouTube Shorts / fast distribution)
      - 16:9 horizontal (website player)
      File naming: Orbital_Pioneers_Ep{episode_number}_{Title}_v1.mp4

  # Phase 9: Hand off to Launch
  - id: handoff_to_launch
    command: openclaw.invoke --workflow prepare-launch.lobster
    inputs:
      video_path: $final_render.output
      episode_number: $episode_number
      episode_title: $episode_title
