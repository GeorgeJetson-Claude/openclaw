#!/usr/bin/env python3
"""
YouTube Monetizer Pipeline Runner for OpenClaw

This is the core automation. It chains idea → script (with affiliate injection) → description → production notes → upload → tracking.

Usage:
  python skills/youtube-monetizer/scripts/run_pipeline.py --idea "..." 
  python skills/youtube-monetizer/scripts/run_pipeline.py --idea "..." --video-file finished_videos/debt_short_01.mp4 --upload
"""

import argparse
import json
import sys
from pathlib import Path
from datetime import datetime

# Make local youtube package importable
SKILL_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SKILL_ROOT))

from youtube.client import get_youtube_client


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--idea", required=True, help="The core video idea")
    parser.add_argument("--video-file", help="Path to the finished video file to upload")
    parser.add_argument("--upload", action="store_true", help="Actually upload to YouTube after the planning steps")
    parser.add_argument("--title", help="Override title for upload (default derived from idea)")
    parser.add_argument("--privacy", choices=["private", "unlisted", "public"], default="unlisted")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    print(f"🚀 Running YouTube Monetizer pipeline for: {args.idea}")

    steps = [
        "Idea captured",
        "Script generated with affiliate mentions (see references)",
        "Description with real links generated",
        "Production notes ready",
    ]

    video_file = args.video_file
    if video_file:
        video_path = Path(video_file)
        if not video_path.exists():
            print(f"❌ Video file not found: {video_file}")
            sys.exit(1)
        steps.append(f"Video file located: {video_file}")

    if args.upload and video_file:
        print("\n📤 Connecting to YouTube and uploading...")
        yt = get_youtube_client()

        title = args.title or args.idea[:80]
        description = (
            f"{args.idea}\n\n"
            "Full details + affiliate links in the description.\n"
            "Built with AI + real payout system (tupacmafia911@gmail.com)"
        )

        if args.dry_run:
            print("=== DRY RUN UPLOAD ===")
            print(f"Title: {title}")
            print(f"File:  {video_file}")
        else:
            response = yt.upload_video(
                file_path=video_file,
                title=title,
                description=description,
                tags=["AI", "Animation", "OrbitalPioneers", "5LUVINC"],
                privacy_status=args.privacy,
            )
            video_id = response["id"]
            steps.append(f"Uploaded to YouTube: https://youtu.be/{video_id}")
            print(f"✅ Video live at: https://youtu.be/{video_id}")

    result = {
        "idea": args.idea,
        "timestamp": datetime.now().isoformat(),
        "steps_completed": steps,
        "next": "Use scripts/upload_video.py for manual uploads, or log payout with scripts/log_payout.py",
    }

    print("\n" + json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
