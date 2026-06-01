# orbital-promo (VHS)

The dedicated Marketing & Video agent for Orbital Pioneers.

**Agent Name:** VHS  
**Focus:** 90s Saturday morning hype + modern conversion marketing + video production

## Quick Start

```bash
# Full launch campaign
openclaw taskflow run skills/orbital-promo/workflows/full-launch-campaign.lobster \
  --input episode="Ep1" \
  --input launch_date="this Saturday"

# Just Shorts
openclaw taskflow run skills/orbital-promo/workflows/create-youtube-shorts.lobster \
  --input episode="Ep1"

# Thumbnail explosion
openclaw taskflow run skills/orbital-promo/workflows/thumbnail-factory.lobster \
  --input episode="Ep1" \
  --input focus="main_episode"
```

## Available Workflows

- `create-youtube-shorts.lobster`
- `thumbnail-factory.lobster`
- `ad-video-concepts.lobster`
- `full-launch-campaign.lobster`

## Prompt Library

See `references/prompt-library.md` for the sacred 90s marketing voice rules.

## Team Integration

VHS is registered in the Master Device and can be handed work through the Team Room (#revenue / #launch).

**Registry ID:** `vhs-promo`

Adventure first. Family always. Let's sell some hoodies.
