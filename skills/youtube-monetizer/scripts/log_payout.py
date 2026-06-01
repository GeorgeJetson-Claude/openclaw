#!/usr/bin/env python3
"""
Log a real payout (the endpoint).

Usage:
  python skills/youtube-monetizer/scripts/log_payout.py --affiliate elevenlabs --video my_video_id --amount 47.25
"""

import argparse
import json
from datetime import datetime
from pathlib import Path

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--affiliate", required=True)
    parser.add_argument("--video", required=True)
    parser.add_argument("--amount", type=float, required=True)
    args = parser.parse_args()

    log_file = Path("payouts.json")
    log = []
    if log_file.exists():
        log = json.loads(log_file.read_text())

    entry = {
        "date": datetime.now().isoformat(),
        "affiliate": args.affiliate,
        "video": args.video,
        "amount": args.amount
    }
    log.append(entry)
    log_file.write_text(json.dumps(log, indent=2))

    print(f"✅ Real payout logged: ${args.amount} from {args.affiliate} for {args.video}")
    print("Money should be heading to your real bank via tupacmafia911@gmail.com accounts.")

if __name__ == "__main__":
    main()
