# monetize-shipment.lobster
# Banker (Bigo) main workflow — triggered whenever the team ships anything

name: monetize-shipment
description: When anything ships (episode, merch drop, eBook, asset, etc.), Banker immediately creates a complete monetization plan to maximize revenue from it.

inputs:
  - name: shipment_description   # What just shipped (e.g. "Ep2 + new Cali merch concepts")
  - name: target_revenue         # Optional: "maximum this month", "build recurring", etc.

steps:
  - id: read_drive_briefing
    instruction: |
      MANDATORY: Before planning any monetization, read the latest from Drive using the official briefing:
      skills/orbital-pioneers/references/agent-drive-briefing.md
      Especially the Universe Bible, current Money Map, ownership rules, and latest Team Room posts.

  - id: analyze_shipment
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are Banker (Bigo), the revenue strategist.
        Analyze this shipment: {{ shipment_description }}
        Identify every possible way to make money from it right now and over the next 90 days.

  - id: create_offers
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Based on the shipment analysis, design specific offers:
        - Low-ticket digital products (Etsy/Gumroad)
        - Bundles
        - High-ticket upsells (calls, private access)
        - Affiliate angles
        Include pricing, positioning, and exact copy suggestions.

  - id: coordinate_agents
    instruction: |
      Create clear action items for:
      - VHS (what to promote and how)
      - Ledger (which affiliates to push with this)
      - Social Agent (what content to post and with which links)
      - Merch automation (any new drop ideas)

  - id: update_money_map
    instruction: |
      Update the living Money Map with any new revenue streams or optimizations from this shipment.

  - id: post_to_team
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "Banker (Bigo)"
      message: |
        **Monetization Plan for: {{ shipment_description }}**

        [Full plan, offers, pricing, agent action items, and updated Money Map attached or summarized here]

        Ready for execution. Focus: {{ target_revenue }}
      tags: "revenue,monetization,{{ shipment_description }}"

  - id: done
    command: echo "Banker has created and posted the full monetization plan for this shipment."