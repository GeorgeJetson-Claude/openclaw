# Free Video Animation Pipeline Reference

This skill uses the complete free pipeline documented at:

**`/home/tupacmafia911/FREE_VIDEO_ANIMATION_PIPELINE.md`**

Key tiers:

- Tier 1 (Ship fast): Photopea + DaVinci Resolve / CapCut (Ken Burns + parallax + 90s effects)
- Tier 2: Synfig Studio or OpenToonz for real character animation
- Tier 3: Blender Grease Pencil

All audio/SFX/voices can be generated with Gemini + free TTS tools.

## Integration with Lobster

The `generate-episode.lobster` workflow breaks the pipeline into discrete, orchestratable steps that different AIs (Grok, Claude, Gemini) can own.

Run the Lobster files from OpenClaw to coordinate the entire human + AI team.

## Current Focus

**Episode 1: The First Leap** (Nova family crash landing on the Moon, Zara saves the day).

Assets live in Google Drive (shared "Drive Beta" folders with panels, character sheets, audio).

Final delivery:

- High-quality 9:16 Short for quick distribution
- Horizontal version for the website player (`my-landing-page/orbital-pioneers.html`)
- Hosted cheaply on Google Drive (with Cloudflare Worker proxy when needed)

See also: `cheap-gdrive-player/` folder for the actual player code and instructions.

**Ship the cartoon. Make it the best free one possible. Then monetize hard.**
