---
name: reducing-entropy
description: Use when evaluating designs, reviewing code, or refactoring with a bias toward a smaller final codebase. Measures success by total code and concepts after the change, not by how easy the patch is. Trigger when deciding what to delete, whether a refactor is worth it, or whether a proposed design adds unnecessary complexity.
---

# Skill: reducing-entropy

## Purpose

Reduce the total code and concepts the codebase must carry after the change.

The core question is: what does the codebase look like after? Success is a
smaller, simpler end state, not the smallest patch or the easiest implementation.

## Critical Rules

- Must bias toward deletion and fewer concepts.
- Must measure the final codebase, not the effort to get there.
- Must ask what can be removed, merged, avoided, or made obsolete.
- Must challenge net code increases; proceed only when added code is required.
- Must prefer simple over familiar when the familiar path adds moving parts.
- Must load one `references/*.md` mindset before analysis when available.
- Must state which mindset was loaded and its core principle.
- Never keep code only because it already exists.
- Never add flexibility without a concrete expected use.
- Never treat more layers, abstractions, files, or types as automatically cleaner.

## When to Use

- Evaluating a proposed design or refactor.
- Reviewing code for unnecessary complexity.
- Choosing between keeping, replacing, simplifying, or deleting code.
- Deciding whether new abstraction, configuration, indirection, or type structure
  is worth its cost.

## When Not to Use

- A direct bug fix where the safest change is a small local patch.
- Code that is already minimal for what it does.
- Framework, regulatory, compatibility, or team constraints require the structure.
- The user explicitly wants additive exploration rather than simplification.

## Workflow

1. Load one mindset from `references/*.md` if available; if not, say so and proceed.
2. State the loaded mindset and core principle in one sentence.
3. Describe the current or proposed end state.
4. Identify what the change adds:
   - files
   - functions
   - concepts
   - dependencies
   - configuration
   - states or branches
5. Identify what can be deleted, merged, avoided, or made obsolete.
6. Compare end states by total code and total concepts, not patch size.
7. Recommend the smallest final codebase that satisfies the real constraints.
8. Name any case where extra code is justified because it is expensive to add later
   or required by an explicit constraint.

## Tool/File Handling

- Use `references/` for mindset selection only; do not turn it into a long research
  pass unless the user asks.
- If reference files are unavailable, continue with the critical rules and note the
  missing reference.
- Do not create new reference files during ordinary entropy review.

## Output Requirements

Final response must include:

- Loaded mindset.
- Smallest viable end state.
- What to delete, merge, avoid, or make obsolete.
- Any justified additions and why they are required.
- Recommendation.

## Failure Handling

- If constraints require more code, state the constraint and the smallest compliant
  version.
- If deletion would break required behavior, recommend the smallest safe reduction.
- If the tradeoff is uncertain, name the evidence needed to decide.

## Examples

- Good: write 20 lines that remove 200 lines and one concept.
- Bad: keep 14 functions to avoid writing 2 clearer ones.
