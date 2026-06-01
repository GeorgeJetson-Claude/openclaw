#!/usr/bin/env python3
"""
Simple CLI helper to post to the Orbital Pioneers Team Room.

Usage examples:
    python scripts/team-room-post.py --channel "#production" --message "Ep1 render is ready in Drive."
    python scripts/team-room-post.py --channel "#review" --author "Human" --message "Approved after Claude's notes." --tags "Ep1,approved"

This is a convenience wrapper around the Lobster post workflow.
"""

import argparse
import subprocess
import sys
from pathlib import Path

def main():
    parser = argparse.ArgumentParser(description="Post a message to the Orbital Pioneers Team Room")
    parser.add_argument("--channel", required=True, help="Channel to post in (e.g. #production, #review)")
    parser.add_argument("--author", default="Human", help="Who is posting (default: Human)")
    parser.add_argument("--message", required=True, help="The message content")
    parser.add_argument("--tags", default="", help="Optional comma-separated tags")
    args = parser.parse_args()

    # Resolve the path to the Lobster workflow relative to this script
    script_dir = Path(__file__).resolve().parent
    lobster_path = script_dir.parent.parent / "orbital-pioneers" / "team-room" / "post-to-team-room.lobster"

    if not lobster_path.exists():
        print(f"Error: Could not find Lobster workflow at {lobster_path}")
        sys.exit(1)

    cmd = [
        "openclaw", "taskflow", "run", str(lobster_path),
        "--input", f"channel={args.channel}",
        "--input", f"author={args.author}",
        "--input", f"message={args.message}"
    ]

    if args.tags:
        cmd += ["--input", f"tags={args.tags}"]

    print(f"Posting to Team Room in {args.channel} as {args.author}...")
    try:
        subprocess.run(cmd, check=True)
        print("✅ Posted successfully to Team Room (and bridged to external channels if configured).")
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed to post: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
