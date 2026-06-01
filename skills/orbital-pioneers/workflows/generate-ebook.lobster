# generate-ebook.lobster
# Automated eBook / PDF product generator for Etsy + Gumroad

name: generate-ebook
description: Creates complete, sellable eBook content (Markdown + listing copy) for digital products on Etsy and Gumroad. Focused on Orbital Pioneers universe and revenue.

inputs:
  - name: ebook_type          # "meta", "story", "prompt-pack", "villain-guide", "cali-collection"
  - name: target_audience     # "creators", "kids", "fans", "both"

steps:
  - id: research_angle
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are a professional digital product creator for the Orbital Pioneers brand.
        For a {{ ebook_type }} eBook targeted at {{ target_audience }}, identify the strongest unique angle that will actually sell on Etsy and Gumroad right now.

  - id: write_full_content
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Write a complete, high-quality eBook in Markdown format based on the chosen angle.
        Make it feel authentic to the 90s cartoon energy of Orbital Pioneers.
        Include strong chapter structure, humor, and real value.

  - id: create_etsy_gumroad_copy
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Write optimized product titles, descriptions, tags, and pricing recommendations for both Etsy and Gumroad.
        Focus on keywords that convert for digital downloads in the cartoon / indie animation / AI tools niche.

  - id: suggest_bundles
    instruction: |
      Recommend 2-3 bundle ideas that combine this eBook with other existing products (Cali merch, prompt packs, etc.) for higher average order value.

  - id: post_to_team
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "VHS + eBook Generator"
      message: |
        New eBook product generated: {{ ebook_type }} for {{ target_audience }}.

        Full Markdown content + Etsy/Gumroad listings ready.
        Bundle suggestions included.

        Human review + export to PDF → upload to Etsy + Gumroad.

        This one is ready to sell.
      tags: "ebook,digital-product,etsy,gumroad"

  - id: done
    command: echo "eBook generated and ready for review. Posted to #revenue."