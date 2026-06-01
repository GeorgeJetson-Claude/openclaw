# automated-merch-drop.lobster
# Fully automated merch drop system for Orbital Pioneers + cross-project monetization

name: automated-merch-drop
description: Handles end-to-end merch drops (design, assets, Gumroad listing, website CTAs, promotion via VHS) while protecting focus on shipping Orbital Pioneers episodes.

inputs:
  - name: drop_theme          # e.g. "Ep1 Launch", "Cali Collection", "Villains Drop"
  - name: target_date

steps:
  - id: generate_assets
    command: openclaw.invoke --workflow orbital-pioneers/merch-asset-generation.lobster
    args:
      episode: "current"

  - id: create_cali_variants
    instruction: |
      Generate Cali-specific merch variations (stickers, shirts, digital) using the Cali Revenue Engine.

  - id: build_gumroad_listing
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Create complete Gumroad product listings for the merch drop.
        Include titles, descriptions, pricing strategy, upsells, and email sequence copy.
        Optimize for the {{ drop_theme }}.

        Also generate Printful product setup instructions (product types, pricing, mockups) so the designs can be fulfilled via Printful with no inventory.

  - id: update_all_websites
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        Generate ready-to-paste HTML CTA blocks + image recommendations for all 11+ websites.
        Prioritize Orbital Pioneers sites but include cross-promotion to 5LUVINC and Magnacars where relevant.

  - id: launch_marketing
    command: openclaw.invoke --workflow orbital-promo/full-launch-campaign.lobster
    args:
      episode: "merch-drop"

  - id: post_status
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "VHS + Ledger"
      message: |
        Automated Merch Drop for {{ drop_theme }} is complete.

        - Assets generated
        - Gumroad listings ready
        - Website CTAs prepared for all sites
        - Marketing campaign launched

        Human only needs to review + publish. Orbital Pioneers shipping focus protected.
      tags: "merch,drop,automation"

  - id: done
    command: echo "Automated merch drop executed. Everything ready for review."