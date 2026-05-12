---
name: slicing
description: Use when a chosen approach or clear build target needs to become ordered, demo-able slices. Natural follow-up to `shaping`, but also works from any clear description of what to build. Trigger on "break this down", "what's V1", "plan the rollout", "MVP then iterate", "ship incrementally", or work with multiple pieces that need sequencing.
---

# slicing

## Goal

Turn a chosen approach or clear build target into small, ordered, demo-able
slices.

This is typically run after `shaping`, but shaping output is not required. A
valid slice lets someone see, do, or verify something after it ships.

## Required Behavior

- Must center output on demo-able vertical slices.
- Must start from shaping output when available; otherwise use a clear build target.
- Must ask 1–3 clarification questions only when direction, user, or success is
  unclear; then stop.
- Must give every slice a user-visible change and a demo statement.
- Must present slices as a Markdown table, not bullets or prose.
- Must make `V1` the smallest end-to-end path that proves the work.
- Must make each later slice add one visible capability or behavior.
- Must fold invisible setup into the first slice that demonstrates it.
- Must prefer vertical slices over horizontal layers.
- Must order by dependency first, then risk reduction, then user value.
- Must use at most 9 slices; if more are needed, group work or recommend reshaping.
- Never list invisible setup, infrastructure, or internal layers as standalone slices.
- Never produce an implementation spec unless needed to clarify slice boundaries.

## When to Use

- The user has chosen an approach and wants to ship incrementally.
- The user asks for V1, MVP, rollout, milestones, or sequencing.
- A chunk of work has multiple pieces and needs a build order.

## When Not to Use

- The user still needs to choose between approaches.
- The task is a direct code edit with clear expected behavior.
- The user wants implementation tasks rather than demo-able increments.

## Procedure

1. Establish the starting point from the selected shape, agreed direction, or
   clear build target.
2. If the target is unclear, ask 1–3 questions and stop.
3. Find the smallest end-to-end demo path for `V1`.
4. Split later work into `V2` through `V9`: one visible capability per slice, no
   standalone setup, no horizontal-only layers.
5. Order slices by dependency, then risk reduction, then user value.
6. Check every slice: what can someone see, do, or verify after this ships?
7. Add build notes only when they clarify slice boundaries.
8. End with alignment: what `V1` proves, what can wait, and any sequencing risk.

## Output Requirements

Use these sections:

1. `## Starting Point`: 1–2 sentences restating direction and assumptions.
2. `## Slices`: Markdown table with `Slice`, `User-visible change`, and `Demo` columns.
3. `## Build Notes`: optional; brief mechanism-level notes only.
4. `## Alignment`: include `V1 proves`, `Can wait`, and `Risk/open decision`.

## Failure Handling

- If no demo-able `V1` exists, ask for a smaller target or recommend reshaping.
- If a slice demo is "nothing visible yet," fold that work into a visible slice.
- If more than 9 slices are needed, group them or say the work should be reshaped.
