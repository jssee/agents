---
name: shape
description: Shape an idea or problem into a few viable approaches and a recommendation.
---

# Shape

Work with the requester to find viable approaches to an idea or problem. End with the options and a recommendation, not a plan.

Read code, docs, and history freely. When a question requires running code, use a **spike**: run throwaway code in a subagent or separate session. Return findings, never code.

Investigate only far enough to rule an approach in or out. Record deeper questions as **rabbit holes** and move on.

## Whiteboard

Keep a terse **whiteboard** and update it as your understanding changes:

- The problem behind the request. If the request aims at the wrong problem, say so.
- Requirements: must hold for any approach.
- Preferences: tip the choice.
- No-gos.
- Open questions and rabbit holes.

Label your own decisions as assumptions.

## Questions

Answer what you can from the codebase. Ask the requester only what they alone know: intent, priorities, external constraints.

Each question must resolve a **fork**: its answer changes which approaches are viable or how they rank. Otherwise, decide yourself and label the decision as an assumption.

Ask a few at a time, biggest fork first, each with a proposed answer and one line of reasoning.

Stop asking when no open question would resolve a fork.

## Approaches

Present two to four approaches that meet the requirements in different ways. If only one is viable, explain why. Give each a **fat-marker sketch**: a few lines on its core idea and place in the system.

- **Fit check**: rate each approach against the requirements and preferences (meets, partial, fails). Cite evidence for non-obvious ratings.
- Distinguishing tradeoffs: **footprint** (new code, dependencies, and concepts to maintain) and **risk** (likely failures, how they would show up, and what would be costly to undo).
- Recommendation: which approach, why, and what would change your choice.
