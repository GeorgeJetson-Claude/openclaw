import json
import os
import subprocess

BATCH_FILE = "/home/tupacmafia911/projects/OpenClaw/tasks/Gemini_Videos/batch_01.json"

if os.path.exists(BATCH_FILE):
    with open(BATCH_FILE, 'r') as f:
        jobs = json.load(f)
        for job in jobs:
            print(f"Processing: {job['task_id']}")
            subprocess.run(["python3", "video_generator.py", job['script']])
    os.remove(BATCH_FILE)
