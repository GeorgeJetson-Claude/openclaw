# batch-signup-research.lobster
# The main workflow for the Affiliate Signup Agent (Ledger)

name: batch-signup-research
description: Research relevant affiliate programs for your projects and prepare complete application packages using your real details.

inputs:
  - name: niche                    # e.g. "orbital-pioneers-cartoon" or "creator-tools"
  - name: main_sites               # comma separated list of your websites
  - name: monthly_traffic          # rough estimate
  - name: target_programs          # optional: specific ones like "shareasale,printful,elevenlabs"

steps:
  - id: research_programs
    command: openclaw.invoke --tool llm-task --model grok
    args:
      prompt: |
        You are Ledger, the dedicated Affiliate Signup Agent.
        Research the best current affiliate programs for someone running:
        - Orbital Pioneers cartoon + merch project
        - Multiple websites ({{ main_sites }})
        - Gumroad store
        - Doing a lot of free AI + creative work

        Focus on programs that are:
        - Relatively easy to get approved with new projects
        - Have good commission rates for digital + physical merch
        - Relevant to cartoons, merch, creator tools, or AI

        Return a prioritized list of 8-12 programs with:
        - Program name + network
        - Commission rates
        - Approval difficulty
        - Why it fits this project
        - Direct application link

  - id: prepare_personal_details
    instruction: |
      Prepare a clean, professional "About Me / Project" section using the user's real name and details.
      This will be used across all applications.
      Include: project description, traffic estimates, monetization plans (Gumroad + merch), and why they are a good affiliate.

  - id: generate_applications
    command: openclaw.invoke --tool llm-task --model claude
    args:
      prompt: |
        For the top 6 programs from the research, create complete ready-to-submit application text.
        Optimize the answers for high approval rates.
        Use the user's real project details.

  - id: create_tracking_sheet
    instruction: |
      Create a simple tracking system (Markdown table) for:
      - Program name
      - Application status (Not Started / Submitted / Approved / Rejected)
      - Date applied
      - Notes / follow up needed

  - id: post_to_team_room
    command: openclaw.invoke --workflow team-room/post-to-team-room.lobster
    args:
      channel: "#revenue"
      author: "Ledger (Affiliate Agent)"
      message: |
        Affiliate research complete for {{ niche }}.

        Found strong opportunities. Full prioritized list + pre-filled application text ready.
        Tracking sheet created.

        All packages use your real name and project details.

        Ready for you to review and submit when you want.
      tags: "affiliate,signups,{{ niche }}"

  - id: done
    command: echo "Ledger has prepared your affiliate signup packages. Check #revenue channel."