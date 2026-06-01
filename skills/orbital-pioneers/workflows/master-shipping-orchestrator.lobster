# master-shipping-orchestrator.lobster
# The top-level automation that keeps Orbital Pioneers shipping while revenue systems run on autopilot.

name: master-shipping-orchestrator
description: Master automation layer. Prioritizes shipping Orbital Pioneers episodes while running merch drops, affiliate signups (Ledger), and marketing (VHS) in parallel.

inputs:
  - name: current_focus   # "Ep1", "Ep2", "merch-drop", etc.

steps:
  - id: read_drive_briefing
    instruction: |
      MANDATORY FIRST STEP FOR ALL AGENTS:
      Read the following key files from Google Drive before doing anything else:
      - Orbital_Pioneers_Universe_Bible (latest version)
      - TEAM_ROOM.md (latest posts)
      - all-in-my-name-ownership.md
      - Banker Money Map
      - CALI_REVENUE_ENGINE.md and related Cali docs
      - Any recent status/launch/production files
      - LIVE video and asset ID files

      Use the official briefing: skills/orbital-pioneers/references/agent-drive-briefing.md

      Only proceed after you have the latest full picture from Drive.

  - id: post_drive_sync
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Master Orchestrator"
      message: "✅ Drive sync complete. All agents have read the latest Universe Bible, Team Room, Money Map, ownership rules, and current status files."
      tags: "drive-sync,agents"

  - id: protect_orbital_pioneers
    instruction: |
      ALWAYS protect shipping Orbital Pioneers as the #1 priority.
      Run production workflows first (generate-episode, claude-review, etc.).

  - id: run_background_revenue
    command: openclaw.invoke --workflow orbital-promo/automated-merch-drop.lobster
    args:
      drop_theme: "Cali + Ep1 Cross Promo"
    condition: "merch drop is due or new episode is close to launch"

  - id: activate_banker
    command: openclaw.invoke --workflow banker-agent/monetize-shipment.lobster
    args:
      shipment_description: "New shipment in progress"
      target_revenue: "maximum this cycle"
    condition: "anything new is being shipped"

  - id: trigger_reel_render
    instruction: |
      NEW PREFERRED PATH (Pure AI, no human CapCut):
      Once the user has generated the 8 panel video clips using Gemini + the prompts in 
      projects/orbital_pioneers_live/automation/AI_VIDEO_PROMPTS_FOR_GEMINI.md,
      run:
        cd /home/tupacmafia911/projects/orbital_pioneers_live/automation
        python3 ai_video_pipeline.py

      This produces the final 75s vertical cartoon fully automatically using Claude's exact timings + AI clips + audio layers.

      Legacy path (if human polish still wanted):
      openclaw taskflow run skills/video-creator-agent/workflows/render-episode.lobster ... (old command)
    condition: "AI video clips for the 8 panels are ready in the clips/ folder"

  - id: run_affiliate_automation
    command: openclaw.invoke --workflow affiliate-signup-agent/auto-signup-for-all-projects.lobster
    args:
      all_projects: "Orbital Pioneers, 5LUVINC, Magnacars, all other sites"
    condition: "new revenue opportunities detected"

  - id: side_projects_revenue_cycle
    instruction: |
      PARALLEL SIDE PROJECT WORK (every cycle, after protecting Orbital Pioneers):
      - Banker (Bigo): Run monetization plans specifically for side projects:
        * quote-my-roofer: Optimize for richest ZIP codes (Atherton 94027, Beverly Hills 90210, Greenwich 06830, Fisher Island, etc.). Promote the Baseball Home Run Derby game as lead magnet. Create bundles with Orbital Pioneers merch.
        * magnacars-core / dealer-funnel: Improve bidding funnels, pricing, affiliate angles.
        * 5luvinc-brand + creator-tools: Productize brand assets + tools as sellable digital products.
      - Social Agent (Echo): Create and schedule promo for side project assets (new ZIP pages, baseball game on quote sites, magnacars leads).
      - VHS: Generate marketing assets (thumbnails, shorts concepts) for side projects.
      - Ledger: Research and prepare affiliate applications that match side projects (home services networks for quote-my-roofer, auto dealer tools for magnacars).
      Post a summary of side project progress to #revenue in Team Room.
    condition: "always run in background (Continuous Running Mode)"

  - id: trigger_vhs_marketing
    command: openclaw.invoke --workflow orbital-promo/full-launch-campaign.lobster
    condition: "new episode or merch drop ready"

  - id: post_daily_status
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#general"
      author: "Master Orchestrator"
      message: |
        Daily automation status:
        - Orbital Pioneers shipping: [PROTECTED / ON TRACK]
        - Merch drops: [status]
        - Affiliate signups (Ledger): [status]
        - Marketing (VHS): [status]

        Everything is running in background. Human focus stays on creative decisions + final approvals.

  - id: generate_daily_briefing
    command: openclaw.invoke --workflow orbital-pioneers/generate-daily-team-briefing.lobster
    args:
      date: "$(date '+%Y-%m-%d')"

  - id: done
    command: echo "Master Shipping Orchestrator cycle complete. Orbital Pioneers remains the priority."