# Orbital Pioneers Skill (OpenClaw)

This skill turns the production and launch of the **Orbital Pioneers** 90s-style cartoon into structured, orchestratable Lobster workflows.

## Current Priority: Ship Ep1

Use this command to run the full Ep1 launch:

```bash
openclaw taskflow run skills/orbital-pioneers/workflows/launch-ep1.lobster
```

This workflow will guide you through:

- Asset preparation from Drive
- Episode generation (script + storyboards + animation via free tools)
- Claude review gate
- Final export
- Cheap Google Drive hosting + website player update
- Revenue activation (Gumroad, merch, etc.)

## Key Lobster Workflows

| Workflow                         | Purpose                                      | When to Use                      |
| -------------------------------- | -------------------------------------------- | -------------------------------- |
| `launch-ep1.lobster`             | Full master for Ep1 launch                   | Right now (current sprint)       |
| `generate-episode.lobster`       | Produce one full episode (free pipeline)     | Any new episode                  |
| `prepare-assets.lobster`         | Organize panels, layers, audio from Drive    | Start of any episode             |
| `prepare-launch.lobster`         | GDrive + website player + SEO + monetization | After a video is rendered        |
| `claude-review.lobster`          | Structured review pass (Claude-optimized)    | Quality gate before final render |
| `ep2-planning.lobster`           | Immediate planning and asset kickoff for Ep2 | Right after Ep1 ships            |
| `merch-asset-generation.lobster` | Design episode/character merch drops         | Alongside any episode            |
| `paid-promo-automation.lobster`  | Generate ad creative and campaign structure  | Before/after episode launch      |

## Integration

- Uses the free animation pipeline documented in `FREE_VIDEO_ANIMATION_PIPELINE.md`
- Delivers video to the cheap GDrive + custom player system (`my-landing-page/orbital-pioneers.html`)
- Feeds the `youtube-monetizer` skill for revenue
- Designed for multi-AI collaboration (Grok + Claude + Gemini)

## Philosophy

- Ship fast with Tier 1 (motion graphics in DaVinci Resolve / CapCut)
- Upgrade quality in later episodes using Synfig, OpenToonz, or Blender Grease Pencil
- Own distribution (website + GDrive first, YouTube as optional)
- Make money from day one via affiliates, merch, and digital products

Adventure first. Family always.
