---
name: shaping
description: Use when working through a fuzzy idea before implementation. Always asks clarification questions first, then produces a requirements table, one or more viable shapes, a fit-check matrix, and a recommendation. Trigger on "not sure which approach", "should we build X or Y", "what's the scope", "tradeoffs", "before we start", or any request where multiple directions are possible.
---

# shaping

## Goal

Turn a fuzzy idea into an aligned direction before implementation.

This is a two-step interaction: ask clarification questions first, then shape
after the user answers.

## Required Behavior

- Must ask 2–5 clarification questions before the first shaping output, even if
  the request seems clear.
- Must stop after asking questions; do not produce requirements, shapes, fit
  check, or recommendation in the same response.
- Must produce a requirements table after the user answers.
- Must produce one or more realistic shapes.
- Must produce a fit-check matrix for every shape.
- Must end with a recommendation.
- Must separate requirements from solutions.
- Never invent weak shapes just to compare alternatives.
- Never treat unknown fit as positive; unknown is ❌.
- Only skip the question-first step if higher-priority instructions forbid asking.

## When to Use

- The user has a fuzzy idea and wants help before implementation.
- Multiple viable directions exist and none is obviously right.
- The user asks about scope, tradeoffs, approach, requirements, or what to build.

## When Not to Use

- The user already chose an approach and wants implementation steps.
- The task is a direct bug fix or code edit with clear expected behavior.
- The user needs execution, not alignment.

## Procedure

1. Clarify first:
   - Ask 2–5 questions about goals, constraints, priorities, users, success,
     non-goals, or risk.
   - If the request seems clear, ask confirmation or priority questions.
   - Stop and wait for the user's answers.
2. Extract requirements after the user answers:
   - Use IDs `R0` through `R8`.
   - Use statuses: `core`, `must`, `nice`, or `out`.
   - State problems or constraints, not solutions.
3. Produce shapes:
   - Label shapes `A`, `B`, `C` as needed.
   - Include one shape when only one realistic direction exists.
   - Describe concrete mechanisms: what would be built, changed, removed, or deferred.
   - Combine overlapping shapes and name the real decision point.
4. Run the fit check:
   - Include one column per shape, even when there is only `A`.
   - Use only ✅ or ❌; unknown counts as ❌.
   - Treat `core` and `must` failures as disqualifying unless the tradeoff is explicit.
5. Recommend the best direction and name any decision that still needs agreement.

## Output Requirements

First response: ask only clarification questions.

Shaping response after answers must use these sections, in order:

1. `## Requirements` with table: `Req | Requirement | Status`.
2. `## Shapes` with `A`, `B`, `C` headings as needed.
3. `## Fit Check` with table: `Req | Requirement | Status | A | ...`.
4. `## Recommendation` with the direction, why it fits, and remaining uncertainty.

## Failure Handling

- If the user gives partial answers, proceed with explicit assumptions.
- If all requirements seem like `must`, ask or state which ones drive the decision.
- If no shape satisfies a `core` or `must`, recommend revising scope.
