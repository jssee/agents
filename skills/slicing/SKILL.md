---
name: slicing
description: Turn a chosen direction into ordered vertical slices.
disable-model-invocation: true
---

# slicing

## Goal

Turn a selected shape or clear build target into small, ordered, demoable vertical slices.

A slice is a tracer bullet: one narrow end-to-end path someone can see, do, or verify after it ships.

## Protocol

1. Establish the starting point.
   - Work from a selected shape, plan, PRD, issue, or clear build target.
   - If direction, user, or success is unclear, ask 1–3 questions only, then stop.
   - When shaping output exists, slice the chosen shape and preserve its non-goals.
   - Complete when the target and outcome are clear enough to slice.

2. Find `V1`.
   - Make `V1` the smallest end-to-end path that proves the direction.
   - Fold required invisible setup into `V1`; never make setup its own slice.
   - Complete when `V1` has a visible outcome.

3. Add later slices.
   - Use `V2` through `V9` as needed.
   - Each later slice adds one visible capability or behavior.
   - Phrase outcomes as `User can...` or `System now...`.
   - Prefer vertical slices over horizontal layers.
   - No standalone infrastructure, refactor, migration, or internal-layer slices.
   - Complete when every required capability is sliced or explicitly deferred.

4. Order the slices.
   - Order by dependency first, then risk reduction, then user value.
   - Mark blockers clearly.
   - Use `None` or earlier slice IDs only in `Blocked by`.
   - Complete when no slice depends on a later slice.

5. Check readiness.
   - Every slice needs a visible outcome and blocker status.
   - If a slice has no visible outcome, fold it into a visible slice.
   - If more than 9 slices are needed, group the work or recommend reshaping.
   - Complete when slices are independently grabbable and reviewable.

6. Align.
   - State what `V1` proves, what can wait, and any sequencing risk.
   - Ask whether granularity and dependencies look right.
   - Do not publish issues or write an implementation plan unless asked.
   - Slice plans are not tickets; only add issue-ready detail if asked.

## Slice Plan

Use these sections in order. Keep bullets terse; avoid explanatory paragraphs.

1. `## Starting Point`

   Restate the direction and assumptions in 1–2 sentences.

2. `## Slices`

   Table: `Slice | Outcome | Blocked by`

3. Optional: `## Build Notes`

   Use only for mechanism notes that clarify slice boundaries.

4. `## Alignment`

   Include `V1 proves`, `Can wait`, `Risk/open decision`, and a short granularity/dependency check.
