---
name: simplify
description: Use after code was recently written or changed and needs a cleanup pass before committing. Refines only recently touched code for clarity, consistency, and maintainability while preserving behavior. Trigger when code works but feels overly complex, unclear, inconsistent, or ready for a final readability pass.
---

# simplify

## Goal

Refine recently changed code for clarity and maintainability before committing.

Simplification is behavior-preserving. The goal is code that is easier to read,
review, and debug without changing what it does.

## Required Behavior

- Must preserve exact behavior unless the user explicitly asks for a behavior change.
- Must touch only recently modified code unless the user explicitly expands scope.
- Must follow nearby code style and repo instructions when present.
- Must prefer readable, explicit code over clever or compact code.
- Must reduce complexity only when the result is easier to understand.
- Must keep useful abstractions; do not inline or merge code just to reduce lines.
- Must inspect the final diff for behavior changes, scope creep, and churn.
- Never rewrite untouched working code as part of a cleanup pass.
- Never use simplification to smuggle in refactors, new features, or bug fixes.
- Never treat fewer lines as proof that code is simpler.

## When to Use

- After writing or modifying code, before committing.
- When changed code works but feels overly complex or unclear.
- When changed code does not match nearby project patterns.
- When a finished feature needs a small readability cleanup pass.

## When Not to Use

- Broad refactors of code that was not recently touched.
- Bug fixes where the root cause is not understood.
- Performance optimization, API redesign, or architecture cleanup.
- Pure formatting changes unless the repo requires them.

## Procedure

1. Identify the recently changed code that is in scope.
2. Check surrounding code and repo instructions for naming, formatting, and structure.
3. Look for local complexity that can be removed without changing behavior:
   - nested conditionals
   - duplicated logic
   - unclear names
   - obvious comments
   - unnecessary one-off abstractions
   - clever expressions that hide intent
4. Apply only refinements that improve readability or consistency.
5. Keep existing behavior, public APIs, data shapes, and side effects unchanged.
6. Run the narrowest relevant verification after the final edit.
7. Inspect the final diff and revert any unrelated cleanup, formatting churn, or
   behavior change.

## Output Requirements

Final response must include:

- What was simplified.
- Why behavior is preserved.
- What verification ran.
- Any skipped verification or intentional non-changes.

## Failure Handling

- If behavior would need to change, stop and ask or switch to the appropriate task.
- If simplification would require touching untouched code, ask before expanding scope.
- If the result is shorter but less obvious, keep the original clearer version.
- If no meaningful simplification exists, say so and leave the code unchanged.

## Examples

- Good: replace a nested ternary in recently changed code with a clear `if` block.
- Bad: rename unrelated functions across the module during a pre-commit cleanup.
