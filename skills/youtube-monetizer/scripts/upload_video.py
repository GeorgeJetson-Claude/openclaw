#!/usr/bin/env python3
"""
Upload a video to YouTube using the youtube-monetizer skill.

Uses the shared ~/.youtube/ credentials (the same ones set up with youtube_authenticate.py).

Usage examples:
    python scripts/upload_video.py --file path/to/video.mp4 --title "My Video" --description "..." --tags tag1,tag2 --privacy unlisted
    python scripts/upload_video.py --file video.mp4 --title "Test" --publish-at "2026-06-15T10:00:00Z"
"""

import argparse
import sys
from pathlib import Path

# Make the local youtube package importable when running the script directly
SKILL_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SKILL_ROOT))

from youtube.client import get_youtube_client


def main():
    parser = argparse.ArgumentParser(description="Upload video to YouTube via OpenClaw youtube-monetizer")
    parser.add_argument("--file", required=True, help="Path to the video file")
    parser.add_argument("--title", required=True, help="Video title")
    parser.add_argument("--description", default="", help="Video description")
    parser.add_argument("--tags", default="", help="Comma-separated tags")
    parser.add_argument("--category", default="24", help="YouTube category ID (default 24 = Entertainment)")
    parser.add_argument("--privacy", choices=["private", "unlisted", "public"], default="private")
    parser.add_argument("--publish-at", help="ISO8601 datetime for scheduled publish (e.g. 2026-06-15T08:00:00Z)")
    parser.add_argument("--dry-run", action="store_true", help="Print what would be uploaded but don't actually upload")

    args = parser.parse_args()

    tags = [t.strip() for t in args.tags.split(",") if t.strip()] if args.tags else None

    print(f"Connecting to YouTube using ~/.youtube/ credentials...")
    yt = get_youtube_client()

    if args.dry_run:
        print("=== DRY RUN ===")
        print(f"File:        {args.file}")
        print(f"Title:       {args.title}")
        print(f"Description: {args.description[:100]}..." if len(args.description) > 100 else f"Description: {args.description}")
        print(f"Tags:        {tags}")
        print(f"Privacy:     {args.privacy}")
        if args.publish_at:
            print(f"Publish at:  {args.publish_at}")
        print("Would upload now.")
        return

    print(f"Uploading {args.file} ...")
    response = yt.upload_video(
        file_path=args.file,
        title=args.title,
        description=args.description,
        tags=tags,
        category_id=args.category,
        privacy_status=args.privacy,
        publish_at=args.publish_at,
    )

    video_id = response["id"]
    print(f"\n✅ Upload successful!")
    print(f"Video ID: {video_id}")
    print(f"Watch (when public): https://youtu.be/{video_id}")


if __name__ == "__main__":
    main()
