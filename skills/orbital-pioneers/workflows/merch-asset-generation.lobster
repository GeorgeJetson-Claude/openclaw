# merch-asset-generation.lobster
# Generate merch concepts, mockups, and launch assets for Orbital Pioneers

name: merch-asset-generation
description: Create high-quality merch concepts (hoodies, tees, prints) tied to specific episodes or characters, ready for Printful/Gumroad.

steps:
  - id: define_merch_drop
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        Design the first merch drop for Orbital Pioneers:
        - Pilot Wings Hoodie (Grandpa Nova’s silver wings on back, small chest logo)
        - Wanderer Ship Tee
        - Echo Beep Stickers / Patches
        Include color palettes (90s cartoon: deep black, orange, teal, magenta), print placements, and pricing strategy.

  - id: generate_visual_assets
    command: openclaw.invoke --tool image-gen --model gemini --count 6
    args:
      style: "Clean vector-style apparel mockups, 90s cartoon aesthetic, bold colors, professional product photography style on white or lifestyle backgrounds"

  - id: write_product_descriptions
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: "Write compelling, story-driven product descriptions for the first merch drop. Tie each item to specific moments or characters from Ep1. Include 'Adventure first. Family always.' tagline."

  - id: prepare_for_printful
    instruction: |
      Export final vector files (or high-res PNGs) in Printful-ready formats.
      Set up products in Printful/Gumroad.
      Link products in the orbital-pioneers.html player page and all future episode descriptions.

  - id: schedule_drop
    instruction: "Plan launch timing: Soft drop with Ep1, bigger push with Ep2."
