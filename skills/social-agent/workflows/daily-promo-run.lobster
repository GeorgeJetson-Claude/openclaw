# daily-promo-run.lobster
# Social Agent main autopilot workflow

name: daily-promo-run
description: Runs the Social Agent on autopilot. Creates and prepares posts for all platforms promoting Orbital Pioneers, merch, eBooks, Cali, affiliates, and the setup call.

inputs:
  - name: new_assets          # What’s new today (episode, merch drop, eBook, Cali moment, etc.)
  - name: priority            # "product_push", "episode_promo", "cali_content", "mixed"

steps:
  - id: read_drive_briefing
    instruction: |
      MANDATORY: Read the latest from Drive first using:
      skills/orbital-pioneers/references/agent-drive-briefing.md
      Pay special attention to the current Universe Bible, Team Room, ownership rules, and latest product status.

  - id: generate_content_ideas
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are the Social Agent for Orbital Pioneers.
        Based on the new assets ({{ new_assets }}), create 6-8 post ideas across platforms.
        Mix: value, behind-the-scenes, Cali content, product promotion, and affiliate links.

  - id: write_platform_posts
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Write ready-to-post copy for:
        - X/Twitter threads or single posts
        - Instagram captions + carousel ideas
        - TikTok/Reels hooks + descriptions
        - YouTube Community posts

        All content must use brand names only: "Orbital Pioneers", "5LUVINC Production", "Cali the Husky", "Quote My Roofer", or "Magnacars" as appropriate.
        Never use or credit any personal name in posts, captions, or generated content.
        Include natural affiliate links and Gumroad/Etsy product CTAs where appropriate.
        Keep the 90s cartoon + fun + Cali energy for main Orbital content.
        For side projects (quote-my-roofer in richest ZIPs, baseball game, magnacars): Use professional yet approachable tone, emphasize "free instant quotes + fun game", target high-intent wealthy area keywords.
        Credit style examples: "from the Orbital Pioneers crew", "Cali the Husky approved", or just the show title. For side projects: "Quote My Roofer — premium matches in the richest ZIPs".

  - id: create_cali_focused_content
    instruction: |
      Generate 3 pure Cali posts (stories, memes, "Cali in ads" moments).
      These perform extremely well and drive emotional connection + sales.

  - id: schedule_and_post_notes
    instruction: |
      Output a simple posting schedule for the next 3-7 days.
      Include best times and platform-specific tips.

  - id: post_to_team_room
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#social"
      author: "Social Agent"
      message: |
        Daily promo run complete for {{ new_assets }}.

        Full post copy, threads, captions, and schedule ready.
        All affiliate links and product CTAs included.

        Human can copy-paste or we can wire this to actual posting tools later.
      tags: "social,automation,{{ priority }}"

  - id: done
    command: echo "Social Agent daily run complete. Content ready in #social channel."