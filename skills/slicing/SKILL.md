---
name: slicing
description: Use after shaping to break a selected solution into vertical implementation increments. Each slice must be demo-able.
---

# Slicing

## Overview

Slicing breaks a shaped solution into ordered, vertical implementation increments. Each slice cuts through all layers to deliver something you can demonstrate.

**Core principle:** Every slice must be demo-able. If you can't describe what someone would see or do to verify the slice works, it's not a slice — it's a layer.

## When to Use

- After shaping has selected a solution (shape)
- The selected shape has multiple mechanisms that need ordering
- You need to plan incremental delivery

**Not for:** Work small enough to build in one shot. If the shape has 2-3 mechanisms and the path is obvious, just build it.

## Prerequisites

A selected shape with its mechanisms listed. Typically from a `shape.md` produced by the `shaping` skill, but any clear description of what to build works.

## What Makes a Good Slice

A slice is **vertical** — it cuts through UI, logic, and data to deliver a working increment.

| ✅ Vertical slice | ❌ Horizontal layer |
|---|---|
| "Widget shows real data from API" | "Set up database schema" |
| "User can search and see filtered results" | "Build search API endpoint" |
| "Admin sees who changed a record" | "Add audit logging infrastructure" |

**The demo test:** Can someone interact with this slice and see it working? If the answer is "well, not directly, but it enables…" — that's a layer, not a slice.

## Slicing

1. **V1 is the smallest demo-able increment.** Core data flowing through all layers to produce something visible. It should feel almost embarrassingly minimal.

2. **Each subsequent slice adds one working mechanism.** Not one file, not one layer — one thing the user can see or do that they couldn't before.

3. **Max 9 slices.** If you need more, the shape is too big. Go back to shaping and split the problem.

4. **Order by dependency, not importance.** V2 might be less important than V5, but V5 depends on V2's mechanism being in place.

## Output

When slicing is done, ask the user where the artifacts should live:

- **Append to `shape.md` or create `slices.md` in the repo**
- **Other** — the user may prefer an external tool (task tracker, wiki, etc.). Summarize the slices in whatever format they need so they can capture it themselves.

If writing to a file, keep it minimal:

```markdown
## Slices

| # | Slice | Demo |
|---|-------|------|
| V1 | Widget with real data | "Widget shows letters from API" |
| V2 | Search with live filtering | "Type 'dharma', results filter live" |
| V3 | Filter state in URL | "Refresh page, filters persist" |
| V4 | Audit trail for changes | "Edit record, see change in history tab" |
```

Each slice: a name, a demo statement in quotes. That's it.

If a slice needs more detail to be buildable, add a brief list of what gets built — but resist the urge to write implementation specs. The code is the spec.

```markdown
### V2: Search with live filtering
- Debounced search input component
- Server-side search endpoint  
- Results list re-renders on response

**Demo:** "Type 'dharma', results filter live"
```

## Red Flags

- **A slice with no demo statement** — if you can't describe what to demo, it's not a slice
- **"Set up X" as a slice** — setup is a layer. What does the setup *enable* that someone can see?
- **V1 is too ambitious** — V1 should make you uncomfortable with how little it does. That's correct.
- **Slices that only touch one layer** — "build all the API endpoints" is horizontal. Each slice should touch whatever layers it needs.
- **More than 9 slices** — the shape is too big. Reshaping is cheaper than managing a 15-slice plan.
- **Detailed implementation specs per slice** — you're over-planning. The slice says *what's demo-able*, not *how to build it*. Let the code emerge.
