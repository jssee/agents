---
name: mechanism-tracing
description: Trace implementation mechanisms and unknowns from source material.
disable-model-invocation: true
---

# mechanism-tracing

## Goal

Turn source material into a mechanism trace: what must become true, how the system would make it true, what is still unknown, and whether the work is ready to slice or build.

A source is the material the user gives you. Preserve its language and IDs.

A mechanism is the concrete path through the system that makes an outcome real. It is not the outcome restated, and it is not a task list.

## Protocol

1. Establish the source.
   - Name the target and assumptions.
   - Ask 1–3 questions only if user, outcome, or success is unclear.
   - Complete when the source is understood well enough to trace.

2. Extract outcomes.
   - Capture what must become true.
   - Preserve source IDs/statuses; otherwise use `O1`–`O9` and `must`, `nice`, or `out`.
   - Complete when every decision-driving outcome is captured or explicitly deferred.

3. Trace mechanisms.
   - For each `must`, name the concrete path through the system.
   - Inspect code or docs when the path depends on the existing system; do not trace from memory.
   - Complete when every `must` has a mechanism or a gap.

4. Mark confidence.
   - `known`: supported by evidence.
   - `risky`: known enough to describe, but fragile, ambiguous, or cross-boundary.
   - `unknown`: needs investigation before relying on it.
   - Complete when every mechanism or gap has confidence.

5. Decide readiness.
   - Ready only when no `must` outcome has a blocking unknown.
   - If not ready, name the smallest clarification or spike.
   - Complete with yes/no readiness and the next move.

## Mechanism Trace

Use these sections in order.

1. `## Source`

   1–3 bullets: source, target, assumptions.

2. `## Outcomes`

   Table: `ID | Outcome | Status`

3. `## Mechanisms`

   Table: `Outcome | Mechanism | Confidence | Evidence`

4. Optional: `## Unknowns`

   Table: `ID | Question | Blocks`

5. `## Readiness`

   Include `Ready`, `Why`, and `Next`.
