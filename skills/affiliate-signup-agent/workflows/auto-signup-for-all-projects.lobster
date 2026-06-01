# auto-signup-for-all-projects.lobster
# Ledger's master automation: Signs up for affiliates across ALL your sites/projects

name: auto-signup-for-all-projects
description: Automatically researches and prepares affiliate applications for every project/site you have (Orbital Pioneers + 5LUVINC + Magnacars + etc.) using your real name.

inputs:
  - name: all_projects          # JSON or list of your projects with niches
  - name: your_name
  - name: your_email
  - name: main_gumroad_store

steps:
  - id: parse_all_projects
    instruction: |
      Take the list of all your projects/websites and categorize them by niche:
      - Orbital Pioneers (cartoon, merch, 90s nostalgia, AI production)
      - 5LUVINC brand/creator tools
      - Magnacars (car-related)
      - Any other sites

  - id: research_by_niche
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are Ledger. For each niche/category from the projects, research the best current affiliate programs that match.
        Prioritize:
        - Easy approval for new/creator projects
        - Good commissions on digital + physical products
        - Relevant to cartoons/merch, creator tools, cars, etc.

  - id: prepare_universal_profile
    instruction: |
      Create one strong "About Me + Projects" profile using {{ your_name }}.
      Include all sites, Gumroad store, traffic estimates, and monetization goals.
      This profile will be reused across applications.

  - id: generate_all_applications
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        For the top recommended programs per niche, generate complete, high-approval application text.
        Customize slightly per project but keep the user's real details consistent.

  - id: create_master_tracking
    instruction: |
      Build a single master tracking spreadsheet (Markdown table) with:
      - Program
      - Which project it matches
      - Status
      - Application text location
      - Next action

  - id: post_to_team
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "Ledger"
      message: |
        Full affiliate signup automation complete for ALL projects.

        Master list of recommended programs + pre-filled applications ready.
        One master tracking sheet created.

        Ready for human to review and submit in batches.

        Focus remains on shipping Orbital Pioneers — this runs in background.
      tags: "affiliate,automation,all-sites"

  - id: done
    command: echo "Ledger has automated affiliate signups across all your sites. Packages in #revenue."