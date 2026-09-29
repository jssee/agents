---
name: slice
description: Slice a clear build target into ordered, demoable vertical increments for review.
disable-model-invocation: true
---

# Slice

Cut a clear build target into ordered **slices**: narrow end-to-end paths through the real system, each ending in a **demo** that is reviewed before work moves on. A slice may span several commits.

Read and run code to find real seams.

## Cutting

- End every slice with a demo sentence: "after this, someone can ___." If you can't write it, the slice is a horizontal layer; recut it.
- **V1** is the **walking skeleton**: the thinnest end-to-end path that proves the chosen direction.
- Each later slice adds one capability, small enough to review in one sitting.
- Put supporting work (setup, migrations, refactors) in the first slice that needs it. If that makes the slice too big, stub or hardcode the edges.
- Order by dependency, then risk (riskiest first), then user value.
- Mark the **cut line** where the target is met; slices below it are optional.
- Mark a slice **ungrounded** when it depends on a mechanism nobody understands yet.

## Handoff

Make the next slice **handoff-ready**: give a builder enough context to build it from the slice alone. Include:

- What the demo proves.
- Supporting work.
- Mechanisms it touches, with pointers.
- Scope boundary: what belongs to later slices.

The builder stops at the demo and reports back.

Later slices remain **fog of war**. Give each one line: demo sentence, dependencies, blockers.

At each checkpoint, revise the remaining slices within the target and make the next one handoff-ready. New work goes below the cut line.
