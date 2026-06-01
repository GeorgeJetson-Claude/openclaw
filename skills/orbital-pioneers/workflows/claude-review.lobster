# claude-review.lobster
# Structured review gate for Orbital Pioneers episodes
# Designed for Claude (or other strong script/quality reviewers)

name: claude-review
description: Run a high-quality review pass on a cartoon episode (script, visuals, pacing, 90s authenticity, emotional beats) before final render.

inputs:
  - name: episode_number
  - name: episode_title
  - name: current_assets_path   # e.g. Google Drive folder or local path with latest render + script + panels

steps:
  - id: prepare_review_package
    instruction: |
      Gather for Claude:
      - Latest timed voiceover script
      - Current storyboard panels or rough cut video
      - Character voice profiles
      - Target runtime and tone notes (90s Saturday morning cartoon)
      Package this cleanly (folder or doc).

  - id: send_to_claude
    instruction: |
      Send the review package to Claude with this prompt template:

      "Review this Orbital Pioneers episode as a 90s cartoon expert.
      Focus on:
      - Story clarity and emotional arc for a family audience
      - 90s Saturday morning authenticity (pacing, dialogue style, visual language)
      - Character voices and consistency (Alex, Maya, Zara, Leo, Echo)
      - Pacing and hook strength for a 75-90 second short
      - Any weak beats or opportunities to make it more memorable

      Give specific, actionable notes. Prioritize what will make the biggest difference for launch."

  - id: receive_claude_notes
    instruction: "Receive Claude's structured feedback. Save it as: episodes/Ep{episode_number}/reviews/Claude_Review_{date}.md"

  - id: human_decision_gate
    instruction: |
      Human (you) reviews Claude's notes and decides:
      - Approve as-is → proceed to final render
      - Minor fixes → create targeted task list
      - Major changes → loop back to script or storyboard step

      Record decision in the review file.

  - id: apply_approved_changes
    condition: human_decision_gate.decision == "minor_fixes"
    instruction: "Execute only the approved changes from Claude's notes. Re-render affected sections only."

  - id: approve_for_launch
    command: echo "Episode {episode_number} approved after Claude review. Ready for final export and prepare-launch workflow."