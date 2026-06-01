# How to Run Lobster Workflows for Orbital Pioneers

## Running a Workflow

From the OpenClaw root:

```bash
# Run a specific workflow
openclaw taskflow run skills/orbital-pioneers/workflows/generate-episode.lobster \
  --input episode_number=1 \
  --input episode_title="The First Leap" \
  --input core_idea="..."

# Run the full Ep1 launch master
openclaw taskflow run skills/orbital-pioneers/workflows/orchestrate-ep1-launch.lobster
```

## Key Integration Points

- `generate-episode.lobster` → produces the video
- `prepare-launch.lobster` → pushes to cheap GDrive + updates your live player at `/orbital-pioneers.html`
- `orchestrate-ep1-launch.lobster` → full chain including the Claude review gate

## When Drive is Available

Update the workflows to include steps like:

- `openclaw drive pull "Orbital Pioneers/Ep1/panels/"`
- `openclaw drive push "Episodes/Live/" --file final_video.mp4`

## Multi-AI Handoffs

The Lobster steps already assign:

- Grok → High-level creative / structure
- Claude → Scripts, reviews, detailed feedback, SEO/promo copy
- Gemini → Image generation, audio prompts, SFX

This matches exactly how your current 5UV team is already working.

Ship fast. Iterate in public.
