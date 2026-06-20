---
name: shaping
description: Compact decision brief for loose ideas before implementation.
disable-model-invocation: true
---

# shaping

## Goal

Turn a loose idea into a compact decision brief before implementation.

## Protocol

1. Clarify first.
   - Ask 2–4 questions only, then stop.
   - Ask only questions whose answers could change the shape.
   - Cover goals, constraints, users, success, non-goals, risks, or decision drivers.
   - Complete when the user has answered or given enough to proceed with assumptions.

2. Extract requirements.
   - Use IDs `R0` through `R8`.
   - Use statuses: `core`, `must`, `nice`, or `out`.
   - State problems, constraints, and outcomes — not solutions.
   - Complete when every decision-driving requirement is captured.


3. Shape options.
   - Prefer 1–3 realistic shapes; one shape is valid.
   - Label shapes `A`, `B`, `C`.
   - Describe direction, deferred work, and main tradeoff.
   - Combine overlaps; name the real decision point.
   - Complete when each shape is distinct and no shape is weak or fake.

4. Fit check.
   - Include one column per shape.
   - Use only `●` or `○` (`●` = hit, `○` = miss).
   - Treat unknown as `○`.
   - Treat failed `core` or `must` requirements as disqualifying unless named as an explicit tradeoff.
   - Complete when every requirement is scored for every shape.

5. Recommend.
   - Recommend a best default, not a forced choice.
   - Name any viable alternative and remaining uncertainty.
   - Do not produce an implementation plan unless asked.
   - Complete with a direction or a stated need to revise scope.

## Decision Brief

After the user answers, use these sections in order. Keep bullets terse; avoid explanatory paragraphs.

1. `## Requirements`

   Table: `Req | Requirement | Status`

2. `## Shapes`

   Headings: `### A — Name`, `### B — Name`, etc.

3. `## Fit Check`

   Table: `Req | Requirement | Status | A | ...`

4. `## Recommendation`

   State the best default, why it fits, any viable alternative, and what remains uncertain.

5. Optional: `## Explore Next`

   Use only when 1–2 viable shapes deserve separate exploration; name each exploration and what it would prove, not how to implement it.
