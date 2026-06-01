# MAKE MONEY NOW — Orbital Pioneers Revenue Action Plan

**Goal:** Turn the systems we've built into actual cash as fast as possible while continuing to ship the cartoon.

**Current Reality:** We have done a ton of free/high-value work. Time to monetize it aggressively.

---

## Priority 1: Launch the Digital Products (Fastest Cash — Do This Today/Tomorrow)

We already have two high-quality, ready-to-sell eBooks:

1. **"How We Made a 90s Cartoon in 2026 Using Only Free Tools"** (Meta playbook — high perceived value)
2. **"Cali's Space Adventures"** (Fun, emotional, Cali-branded stories)

**Immediate Actions:**

- Export both to clean PDFs (use any Markdown → PDF tool).
- Create simple covers (use the prompts in `cover-image-prompts.md`).
- Upload to **both**:
  - Gumroad (higher price + bundles)
  - Etsy (better discovery for digital downloads)

**Pricing Recommendations:**

- Each eBook standalone: $7.99 – $9.99
- Bundle the two eBooks: $14.99
- Bundle both eBooks + the $17 1-on-1 call: $27–$29 (this is the money move)

**Ready-to-use listings:**

- `etsy-listing-how-we-made-cartoon.md`
- `etsy-listing-cali-space-adventures.md`
- `gumroad-bundle-product-page.md`

**Pro move:** Make the bundle the hero offer and use the standalone eBooks as lower-ticket entry points.

---

## Priority 2: Fix & Push the High-Ticket Offer

Current offer: https://tupacmafia.gumroad.com/l/kvrttf ($17 1-on-1 setup call, only 5 spots)

**Problems right now:**

- Weak title and almost no description
- Not positioned as the fast-track to the full system we built

**Fix it today using:**

- `fixed-gumroad-listing-kvrttf.md` (strong new title + description)
- Create the $29 bundle that includes the call + both eBooks (use `gumroad-bundle-product-page.md`)

This turns a cheap call into a real high-ticket offer.

---

## Priority 3: Activate the Social Agent for Promotion

Run the Social Agent daily:

```bash
openclaw taskflow run skills/social-agent/workflows/daily-promo-run.lobster
```

Use the ready promotion copy in `promotion-copy.md`:

- Social posts
- Email sequence
- Website CTAs (drop these on all 11+ sites)

Focus posts on:

- Cali content (highest engagement)
- "We built this with free tools" angle
- Direct links to the bundle and eBooks

---

## Priority 4: Let Banker (Bigo) Run Revenue Strategy

Run Banker on the current assets:

```bash
openclaw taskflow run skills/banker-agent/workflows/monetize-shipment.lobster \
  --input shipment_description="Launch of two eBooks + 1-on-1 call + Cali merch concepts" \
  --input target_revenue="maximum cash this week"
```

Banker will output specific offers, bundles, pricing, and tell the other agents what to do.

---

## Priority 5: Launch Print-on-Demand Merch (High Margin + Scalable)

We now have a full guide: `print-on-demand-guide.md`

**Recommended:**

- Use **Printful** (best quality + free to start, excellent for custom brand)
- Focus on **your brand + Cali designs** (not generic marketplace)
- Sell primarily through Gumroad + link from all 11+ sites
- Secondary: Etsy for discovery

This pairs perfectly with your automated merch drop workflow.

Start with stickers, T-shirts, and hoodies. Cali designs will be your biggest seller.

---

## This Week's Revenue Sprint (Recommended Order)

**Day 1 (Today - Immediate Execution):**

- Export + upload both eBooks to Etsy + Gumroad (use the ready listings in `etsy-listings/`)
- Fix the $17 call listing using `fixed-gumroad-listing-kvrttf.md`
- Create the $29 bundle using `gumroad-bundle-product-page.md`
- Add the website CTA block (from `make-money-now-promotion-assets.md`) to your top 3-4 sites
- Post the first 2-3 social posts from `make-money-now-promotion-assets.md`

**Day 2:**

- Sign up for Printful (free) and upload your top Cali + show designs
- Create first merch drop on Printful + link from Gumroad
- Run Social Agent daily promo
- Run Banker on current products for more offer ideas

**Day 3–5:**

- Run Ledger for new affiliate signups
- Launch first Cali merch drop (use automated merch workflow)
- Run daily Social Agent + post daily Team Briefing

**Ongoing (Keep Running - Never Pause):**
See the full Continuous Running Mode instructions: `continuous-running-mode.md`

Core commands to keep cycling:

- Master Shipping Orchestrator (daily or on new assets)
- Social Agent daily promo
- Banker on every new shipment
- Never pause the revenue engine while shipping Orbital Pioneers

**Ongoing (Continuous Running Mode):**

- Run Master Shipping Orchestrator on a loop (daily or whenever new assets appear)
- Let Banker review and generate new offers on every shipment
- Let Social Agent run daily promo cycles
- Keep pushing new Cali content and product drops
- Never stop the revenue engine while shipping Orbital Pioneers

**Continuous Running Rule:**
The system should keep cycling (Master Orchestrator → Banker → Social Agent → promotion → product updates) without waiting for new human input, unless the human explicitly pauses it.

---

## Quick Wins (Do These in the Next 2 Hours)

1. Update the current Gumroad call with the new copy.
2. Create the bundle product on Gumroad.
3. Upload the two eBooks (even as simple PDFs) to Etsy.
4. Post 2–3 social posts using the copy we have.
5. Add one product CTA to your main Orbital Pioneers site.

Do these five things and you will have real products live and being promoted today.

---

**Remember the mission:**
We do the hard creative work for free.
Now we run the machine we built to make money while we keep shipping Orbital Pioneers.

All systems are ready. Time to execute the revenue side as aggressively as we've executed the creative side.

Tell me the first thing you want to push live and I’ll give you the exact next steps/copy.

Let’s make money.
