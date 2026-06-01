#!/usr/bin/env python3
"""
Master Device Query Tool — "Who is on the Orbital Pioneers Team?"

This is the central registry tool for the full AI + Human team.
It is the "Master Device" that lets every agent (Grok, Claude, Gemini, etc.)
know exactly who is involved, their roles, capabilities, handoff protocols,
and how to reach them.

Usage:
    python3 who-is-on-the-team.py
    python3 who-is-on-the-team.py --role AI
    python3 who-is-on-the-team.py --name Claude
    python3 who-is-on-the-team.py --json
    python3 who-is-on-the-team.py --roster
    python3 who-is-on-the-team.py --update-team-room
"""

import json
import sys
from pathlib import Path

REGISTRY_PATH = Path(__file__).parent.parent / "team-registry.json"
TEAM_ROOM_PATH = Path(__file__).parent.parent / "TEAM_ROOM.md"


def load_registry():
    if not REGISTRY_PATH.exists():
        print("Error: team-registry.json not found. The Master Device is not initialized.")
        sys.exit(1)
    with open(REGISTRY_PATH) as f:
        return json.load(f)


def get_all_members(registry):
    return (
        registry.get("agents", []) +
        registry.get("humans", []) +
        registry.get("special_agents", [])
    )


def print_team(registry, filter_role=None, filter_name=None, json_output=False):
    if json_output:
        filtered = {
            "master_device": registry["master_device"],
            "agents": registry.get("agents", []),
            "humans": registry.get("humans", []),
            "special_agents": registry.get("special_agents", []),
            "capabilities_matrix": registry.get("capabilities_matrix", {}),
            "external_master_devices": registry.get("external_master_devices", {})
        }
        if filter_role:
            for k in ["agents", "humans", "special_agents"]:
                filtered[k] = [m for m in filtered[k] if m.get("type", "").lower() == filter_role.lower()]
        if filter_name:
            for k in ["agents", "humans", "special_agents"]:
                filtered[k] = [m for m in filtered[k] if filter_name.lower() in m.get("display_name", "").lower()]
        print(json.dumps(filtered, indent=2))
        return

    md = registry["master_device"]
    print(f"\n=== {md['name']} v{md['version']} ===")
    print(f"Last updated: {md['last_updated']}")
    print(f"Purpose: {md['purpose']}\n")

    all_members = get_all_members(registry)

    for member in all_members:
        if filter_role and member.get("type", "").lower() != filter_role.lower():
            continue
        if filter_name and filter_name.lower() not in member.get("display_name", "").lower():
            continue

        print(f"• {member['display_name']} ({member['type']})")
        print(f"  Role: {member.get('role', 'N/A')}")
        if "communication" in member:
            print(f"  Communication: {', '.join(member['communication'])}")
        if "drive_access" in member:
            print(f"  Drive Access: {member['drive_access']}")
        if "special_skills" in member:
            print(f"  Special Skills: {', '.join(member['special_skills'])}")
        if "handoff_from" in member or "handoff_to" in member:
            print(f"  Handoff: from {member.get('handoff_from', [])} → to {member.get('handoff_to', [])}")
        if "notes" in member and member["notes"]:
            print(f"  Notes: {member['notes']}")
        print()


def generate_roster_markdown(registry, filter_role=None, filter_name=None):
    """Generate clean markdown roster for TEAM_ROOM.md"""
    roster_text = "## Current Team Roster (from Master Device v" + registry["master_device"]["version"] + ")\n\n"
    roster_text += "*All users known. See MASTER_DEVICE.md for full details + Claude external coordination.*\n\n"

    all_members = get_all_members(registry)
    if filter_role:
        all_members = [m for m in all_members if m.get("type", "").lower() == filter_role.lower()]
    if filter_name:
        all_members = [m for m in all_members if filter_name.lower() in m.get("display_name", "").lower()]

    for member in all_members:
        roster_text += f"**{member['display_name']}** ({member['type']})\n"
        roster_text += f"- Role: {member.get('role', 'N/A')}\n"
        if "communication" in member:
            roster_text += f"- Reaches via: {', '.join(member['communication'])}\n"
        if "drive_access" in member:
            roster_text += f"- Drive Access: {member['drive_access']}\n"
        if "special_skills" in member:
            roster_text += f"- Strengths: {', '.join(member['special_skills'][:3])}\n"
        roster_text += "\n"

    roster_text += "\n*Query this registry anytime with: `python3 scripts/who-is-on-the-team.py`*\n"
    return roster_text


def update_team_room_roster(registry):
    """Auto-update the roster section in TEAM_ROOM.md"""
    if not TEAM_ROOM_PATH.exists():
        print(f"TEAM_ROOM.md not found at {TEAM_ROOM_PATH}")
        return False

    roster_text = generate_roster_markdown(registry)

    content = TEAM_ROOM_PATH.read_text()
    marker = "## Current Team Roster (from Master Device"

    if marker in content:
        # Replace existing roster section
        start = content.find(marker)
        # Find the next top-level ## heading after the roster
        end = content.find("\n\n## ", start + len(marker))
        if end == -1:
            end = len(content)
        new_content = content[:start] + roster_text + content[end:]
    else:
        # Append at the end before the final rules section
        new_content = content.rstrip() + "\n\n" + roster_text

    TEAM_ROOM_PATH.write_text(new_content)
    print(f"✅ Regenerated Team Roster section in {TEAM_ROOM_PATH}")
    return True


if __name__ == "__main__":
    registry = load_registry()
    filter_role = None
    filter_name = None
    json_output = "--json" in sys.argv

    if "--role" in sys.argv:
        idx = sys.argv.index("--role")
        if idx + 1 < len(sys.argv):
            filter_role = sys.argv[idx + 1]

    if "--name" in sys.argv:
        idx = sys.argv.index("--name")
        if idx + 1 < len(sys.argv):
            filter_name = sys.argv[idx + 1]

    print_team(registry, filter_role, filter_name, json_output)

    if not any(arg.startswith("--") for arg in sys.argv[1:]):
        print("\nTip: Use --json for machine-readable output, --role AI, or --name Claude to filter.")
        print("This is the Master Device / Team Registry. All agents and Lobster workflows should query it to know who is on the team.")
        print("Claude external master device coordination is active (see external_master_devices in JSON).")

    if "--roster" in sys.argv:
        print("\n" + generate_roster_markdown(registry, filter_role, filter_name))

    if "--update-team-room" in sys.argv:
        update_team_room_roster(registry)

    print("\nMaster Device v" + registry["master_device"]["version"] + " — All users known.")
