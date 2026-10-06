---
name: slice
description: Slice a clear build target into ordered, demoable vertical increments for review.
---

# Slice

A **slice** is a narrow end-to-end path through the real system that ends in a **demo**: something someone can do afterward that they couldn't before. Slices sequence the work, not the commits; one slice usually lands as several commits, each kept reviewable.

Read the code before slicing so the seams are real.

- Write each demo as "after this, <actor> can ___." If you can't, the slice is a horizontal layer; recut it.
- V1 is the **walking skeleton**. Find it by asking: "What's the smallest end-to-end path that shows the core mechanism working?" Defer anything that refines the mechanism rather than proves it.
- Each later slice adds one capability and fits in a single fresh context window.
- Fold setup, migrations, and refactors into the first slice that needs them; stub the edges if that makes it too big.
- Order by dependency.

## Output

A table of every slice, then V1 in detail.

| #   | Demo | Depends on |
| --- | ---- | ---------- |

### V1: <name>

- **Proves:** what the demo shows about the direction.
- **Supporting work:** setup, migrations, or refactors V1 must include.
- **Out of scope:** what later slices own.

The builder stops at V1's demo and reports back.
