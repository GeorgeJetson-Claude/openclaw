# CONTINUOUS RUNNING MODE — Keep the Machine Going

**Rule:** Once we enter "Ship + Make Money" mode, the system should keep cycling on its own as much as possible.

## Daily / Recurring Commands (Run These on Loop)

**Core Loop (Run at least once per day):**

1. `openclaw taskflow run skills/orbital-pioneers/workflows/master-shipping-orchestrator.lobster`
2. `openclaw taskflow run skills/social-agent/workflows/daily-promo-run.lobster`
3. `openclaw taskflow run skills/banker-agent/workflows/monetize-shipment.lobster` (whenever new material exists)

**Revenue Push (Run when you have new assets):**

- Run Banker on the new shipment
- Run Social Agent with fresh content
- Push new product links / CTAs to websites

**Product Creation (As needed):**

- `openclaw taskflow run skills/orbital-pioneers/workflows/generate-ebook.lobster` (when new material is ready for a new digital product)

**Communication:**

- Use `@all-agents` broadcast when you need input from the whole team
- Check the Daily Team Briefing every day

## Mindset

- The human focuses on creative direction, final approvals, and real-world sign-ups. All agent execution uses brand names only.
- The agents + workflows handle execution, promotion, product creation, and revenue.
- We only pause when the human explicitly says "pause" or "focus only on [specific thing]".

This is how we ship Orbital Pioneers fast while the money machine keeps running in the background.

**Status:** Continuous Running Mode = ON until further notice.
