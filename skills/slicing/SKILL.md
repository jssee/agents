---
name: slicing
description: Use after an approach is chosen and the user wants to build it incrementally. Helps turn an agreed direction into ordered, demo-able slices. Trigger on phrases like "break this down", "what's V1", "plan the rollout", "MVP then iterate", "ship incrementally", or whenever the work has multiple pieces that need sequencing. Natural follow-up to `shaping`, but any clear description of what to build is enough.
---

# Slicing

Use this skill to align on how to ship an agreed direction in small, demo-able increments.

## Goal

Turn a chosen approach into a short sequence of vertical slices.

A slice is valid only if someone can interact with it or observe it working.

Do not default to producing a formal plan document. Keep the interaction lightweight unless the user asks for a file, task tracker, or wiki-ready output.

## Operating rules

* Start from the agreed direction, selected approach, or current understanding of what to build.
* If the direction is still unclear, ask at most 2-3 questions before slicing.
* Each slice must have a demo statement.
* V1 should be the smallest end-to-end path through the system.
* Each later slice should add one visible capability or behavior.
* Prefer vertical slices over horizontal layers.
* Order by dependency first, then risk reduction, then user value.
* Use at most 9 slices. If more are needed, the approach is probably too large and should be reshaped.
* Avoid implementation specs unless the slice would otherwise be ambiguous.

## Slice test

A good slice answers:

> What can someone see, do, or verify after this ships?

Good:

* "User sees real results from the API."
* "User searches and sees filtered results."
* "Admin edits a record and sees the change in history."

Bad:

* "Set up database schema."
* "Build API endpoints."
* "Add audit logging infrastructure."

If the demo is "nothing visible yet," it is not a slice. Fold that work into the first slice that proves it.

## Conversation pattern

Use only the sections that help.

### Starting point

Briefly restate the agreed direction and any sequencing assumptions.

### Slices

List slices as `V1`, `V2`, `V3`, up to `V9`.

Each slice should include:

* a short name;
* what changes from the user's point of view;
* a demo statement.

Example:

| Slice | User-visible change           | Demo                                                      |
| ----- | ----------------------------- | --------------------------------------------------------- |
| V1    | Widget shows real data        | "Open the page and see live data from the API."           |
| V2    | Search filters results        | "Type a query and see the result list update."            |
| V3    | Filter state survives refresh | "Apply filters, refresh, and see the same filtered view." |

### Build notes

Add brief build notes only when useful for clarity.

Keep them mechanism-level, not implementation-spec-level.

Example:

#### V2: Search filters results

Build:

* search input
* server-backed query
* result list update

Demo: "Type a query and see the result list update."

### Alignment

End by calling out:

* what V1 proves;
* what can safely wait;
* any sequencing risk or open decision.
