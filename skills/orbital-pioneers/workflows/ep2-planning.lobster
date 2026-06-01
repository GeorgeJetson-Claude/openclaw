# ep2-planning.lobster
# Planning and asset kickoff for Episode 2: "The Ghost Signal"

name: ep2-planning
description: Plan and prepare assets for Episode 2 (ancient ghost freighter signal) immediately after Ep1 launch to maintain momentum.

steps:
  - id: define_ep2_concept
    command: openclaw.invoke --tool llm-task --model grok --thinking high
    args:
      prompt: |
        Expand this high-level idea into a full Episode 2 concept for Orbital Pioneers:
        "The Nova family receives an ancient distress signal from a derelict ghost freighter (Kirova-7) drifting in deep space. Grandpa Nova’s old ship? They board it and discover something that changes everything."
        Include logline, 3-act structure, 8-10 key visual moments, emotional stakes, and teaser for Ep3.

  - id: write_ep2_script_outline
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: "Turn the Ep2 concept into a detailed script outline with timed beats, character moments for Alex, Maya, Zara, Leo, Echo, and a strong cliffhanger. Target 8-12 minute episode runtime."

  - id: generate_ep2_storyboards_prompts
    command: openclaw.invoke --tool llm-task --model gemini
    args:
      prompt: "Create detailed image generation prompts for 10 key storyboard panels for Ep2 'The Ghost Signal'. 90s cartoon style: bold outlines, vibrant colors, dramatic lighting."

  - id: create_ep2_production_folder
    instruction: |
      Create this structure in Google Drive and locally:
      Orbital_Pioneers/Ep2_The_Ghost_Signal/
        ├── concepts/
        ├── storyboards/
        ├── audio_prompts/
        ├── references/
        └── production_notes/

  - id: assign_next_ai_tasks
    command: openclaw.invoke --tool message --action broadcast
    args:
      content: |
        Ep1 is shipping. Ep2 planning is live.
        - Grok: Final concept + visual moments (done)
        - Claude: Full script outline
        - Gemini: Storyboard prompts + audio concepts
        Next: Once Ep1 is live, start asset generation for Ep2 immediately.

  - id: link_to_monetization
    instruction: "Begin planning one digital product or merch drop tied to Ep2 (e.g. Ghost Freighter art prints or prompt kit expansion)."
