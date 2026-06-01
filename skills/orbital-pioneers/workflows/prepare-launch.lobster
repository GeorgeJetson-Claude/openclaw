# prepare-launch.lobster
# Finished video → Cheap GDrive hosting → Website player live → SEO + promo assets → Revenue hooks active

name: prepare-launch
description: Take a rendered Orbital Pioneers episode and make it publicly available + monetization-ready using only free/cheap tools.

inputs:
  - name: video_path
  - name: episode_number
  - name: episode_title

steps:
  # 1. Host on cheap Google Drive
  - id: upload_to_gdrive
    instruction: |
      Upload video + best thumbnail to Google Drive folder:
      Orbital_Pioneers/Episodes/Live/
      Share as "Anyone with the link - Viewer".
      Record the two File IDs (video + thumbnail).

  # 2. Update the live website player
  - id: update_website_player
    command: openclaw.invoke --tool edit-file --path my-landing-page/orbital-pioneers.html
    args:
      replacements:
        - find: "REPLACE_EP1_VIDEO_ID"
          replace: "$DRIVE_VIDEO_ID"
        - find: "REPLACE_EP1_THUMBNAIL_ID"
          replace: "$DRIVE_THUMBNAIL_ID"
    note: "This makes the cartoon instantly watchable on your site via cheap GDrive."

  # 3. Optional better streaming (Cloudflare Worker proxy)
  - id: deploy_worker_if_needed
    instruction: |
      If direct GDrive links are slow:
      Deploy the worker from cheap-gdrive-player/cloudflare-worker-gdrive-proxy.js
      Then update the player src to use your worker URL + ?file=ID

  # 4. Generate launch assets (Claude strong here)
  - id: generate_full_seo_and_promo
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        Using the actual episode script, visuals, and the template in Ep1_YouTube_SEO_Package_Ready.md:
        - Final YouTube title + description + tags
        - 3 social media launch posts (different tones)
        - Thumbnail text overlay suggestions
        - Pinned comment with Gumroad + merch CTAs
    stdin: $video_path

  # 5. Wire into revenue system
  - id: register_in_monetizer
    command: openclaw.invoke --tool edit-file --path skills/youtube-monetizer/scripts/run_pipeline.py
    args:
      note: "Log this episode + link to the live GDrive player URL so affiliate tracking and payout logging can reference it."

  # 6. Notify the full team
  - id: notify_full_team
    command: openclaw.invoke --tool message --action broadcast
    args:
      channels: [telegram, discord]
      content: |
        🚀 Orbital Pioneers Ep {episode_number} is LIVE on the website player.
        GDrive: [link]
        Watch + support: https://yourdomain.com/orbital-pioneers.html
        Next: Paid promo push + Episode 2 production kickoff.

  - id: final_ship_reminder
    command: echo "Episode is now publicly watchable for free. Revenue hooks are wired. Run SHIP_IT_NOW.md for the final promo checklist."
