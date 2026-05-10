---
name: minimal-editing
description: Use when modifying existing code in a brown-field codebase: bug fixes, failing tests, PR feedback, small behavior changes, or requested edits where existing structure should be preserved. Prevents over-editing by setting a narrow patch boundary, making the smallest correct change, rejecting unrelated cleanup, and reviewing the final diff before responding.
---

# Skill: minimal-editing

## Purpose

Make existing-code changes with the smallest correct patch. A patch can be
functionally correct and still bad if it rewrites working code, expands scope, or
adds reviewer burden.

Preserve existing structure, names, formatting, and control flow unless changing
them is required to satisfy the request.

## Critical Rules

- Must treat brown-field code as intentional until evidence says otherwise.
- Must understand the requested behavior or failure before editing.
- Must keep the patch inside the smallest safe boundary.
- Must prefer local edits to constants, operators, arguments, selectors,
  conditions, or call sites before rewriting blocks.
- Must not do unrelated cleanup, broad formatting, helper extraction, renames,
  style conversion, or speculative validation.
- Must inspect the final diff hunk by hunk after the last edit.
- Must remove any hunk that is not required for the request.
- Must verify with the narrowest relevant check available.
- Never use passing tests to justify unrelated rewrites.
- Never hide a larger patch; explain why it is required and how it is bounded.

## When to Use

- Fixing a bug in existing code.
- Addressing failing tests.
- Applying PR or review feedback.
- Making a small behavior change in existing files.
- Editing code where the user did not ask for refactoring, redesign, or cleanup.

## When Not to Use

- Pure green-field work with no existing code to preserve.
- Explicit refactors, rewrites, migrations, or modernization tasks.
- Exploratory design work before an implementation direction is chosen.

If the user explicitly asks for a refactor, still avoid unrelated changes, but do
not force a bug-fix-sized patch.

## Workflow

1. Classify the task as brown-field or green-field.
2. For brown-field work, identify the smallest behavior that must change.
3. Inspect the owning code and nearby tests before editing.
4. Define a narrow patch boundary, such as:
   - one conditional
   - one call argument
   - one parser branch plus one regression test
   - one component prop mapping
5. Edit inside that boundary.
6. If the boundary must grow, pause and justify why the smaller patch is unsafe or
   insufficient.
7. Prefer adding or updating the narrowest regression test that proves the change.
8. Run the most relevant available verification after the final edit.
9. Inspect the final diff hunk by hunk.
10. Revert optional cleanup, formatting churn, renames, or helper extraction.
11. Stop when the request is satisfied, verification is complete, and the diff has
    no unrelated hunks.

## Tool/File Handling

- Prefer precise file edits over broad rewrites.
- Avoid running formatters that rewrite unrelated code unless the repo requires it.
- If a formatter or generator changes unrelated code, revert or isolate that churn
  when feasible.
- Do not touch unrelated files because they look messy.
- If unrelated local changes already exist, avoid modifying them and mention the
  constraint if relevant.

## Output Requirements

Final response must include:

- What changed.
- Why the patch is sufficient.
- What verification ran.
- Any skipped or unavailable verification.
- Any larger-than-expected change and why it was necessary.

Keep optional cleanup as a follow-up recommendation, not a silent patch.

## Failure Handling

- If the requested behavior is unclear, ask one narrow question.
- If the failure cannot be reproduced, document the attempted check and use the
  next-best evidence.
- If the smallest safe fix would change public API, data shape, persistence,
  security behavior, or broad architecture, ask before proceeding unless the user
  already authorized that scope.
- If the final diff exceeds the expected boundary, either shrink it or explain the
  evidence that makes the larger patch necessary.

## Examples

- Minimal fix: change `range(len(items) - 1)` to `range(len(items))` when the bug
  is a skipped final item.
- Over-edit: rewriting the loop, renaming variables, adding validation, and
  reformatting the function when the one-line fix was enough.
