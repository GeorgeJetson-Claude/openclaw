# prepare-assets.lobster
# Prepare all assets for a new Orbital Pioneers episode from Drive + production docs
# Focus: Ep1 "The First Leap" and future episodes

name: prepare-assets
description: Organize storyboard panels, character layers, audio, and references from Google Drive into a clean production folder ready for DaVinci Resolve / animation.

inputs:
  - name: episode_number
  - name: episode_title

steps:
  - id: pull_from_drive
    instruction: |
      Pull from Google Drive (when mounted or via public links):
      - All storyboard panels for this episode (currently in "Drive Beta")
      - Character reference sheets (Alex, Maya, Zara, Leo, Echo)
      - Any existing audio (AUD-01 to AUD-05 + SFX)
      - Thumbnails and key art from Landing_Page_Assets folders

      Target local/Drive structure:
      Orbital_Pioneers/Ep{episode_number}/
        ├── panels/
        ├── layers/          (after separation)
        ├── audio/
        ├── references/      (scripts, voice profiles, etc.)
        └── exports/

  - id: separate_layers
    instruction: |
      For each panel:
      Use Photopea (free) to create these layers:
      - Background
      - Midground / Environment
      - Main Characters
      - Props / Effects
      - Text / Overlays (optional)

      Export as PNG with transparency. Name clearly (e.g. panel_01_background.png).

  - id: organize_references
    instruction: |
      Copy relevant docs into the episode folder:
      - Ep{number}_Voiceover_Script
      - CapCut_Master_Assembly_Script (or equivalent)
      - Character_Voice_Profiles
      - Any production notes from Claude/Gemini

  - id: validate_assets
    instruction: |
      Confirm you have:
      - 8+ clean layered panels
      - Full timed script
      - Audio files or clear prompts for Gemini/ElevenLabs
      - Character references ready for animation

  - id: ready_for_animation
    command: echo "Assets for Ep {episode_number} are organized and ready for animate_in_davinci step in generate-episode.lobster"