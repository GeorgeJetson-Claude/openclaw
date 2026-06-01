# CRM Agent — Score + Handoff Workflow
# Triggered by Master Shipping Orchestrator, Claude Drive pings, or manual Claw Dashboard use.

name: crm-score-and-handoff

description: "Re-score entire lead pipeline from all sources (quote forms, baseball game plays, affiliate clicks, Drive submissions). Rank by wealth + intent. Generate handoff packets for Ledger on 90+ score leads. Push revenue summary to Banker."

inputs:
  - source: "Where the new leads came from (Drive, baseball game, quote forms, etc.)"
  - priority: "richest ZIPs first | fastest follow-up | highest value"

steps:
  - command: "Read agent-drive-briefing.md (MANDATORY)"
  - command: "Pull latest leads from Claw Dashboard local state + any new Drive quote submissions"
  - command: "Apply scoring rules (ZIP wealth + source intent + recency)"
  - command: "Generate ranked list + top 5 handoff recommendations for Ledger"
  - command: "Write revenue pipeline note for Banker (total qualified value + biggest opportunities)"
  - command: "Post clean summary to Team Room + #crm channel in Slack"
  - command: "If high-value richest ZIP leads exist: trigger Ledger to prepare exact APPLY packets"

outputs:
  - Updated leads table (exportable)
  - Handoff list for Ledger with packet references
  - Revenue note for Banker
  - Activity log entry for Claw Dashboard

# This workflow is intentionally lightweight because the real power lives in the Claw Dashboard UI.
# The dashboard is the daily driver. This lobster is for big batch runs or full automation cycles.