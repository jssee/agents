---
name: minimal-editing
description: "Use whenever modifying existing code, fixing bugs, applying review feedback, or making a requested change in a brown-field codebase. This skill prevents AI over-editing: preserve existing structure, make the smallest correct patch, avoid while-i-am-here refactors, and inspect the diff for unrelated churn. Trigger especially for bug fixes, test failures, small feature changes in existing files, PR comments, and any task where code already exists and the user did not explicitly ask for a refactor."
---

# Minimal Editing

## Overview

Fix the requested problem without rewriting code that was already working.

In existing codebases, a correct patch can still be bad if it is larger than necessary. Extra helpers, renamed variables, new validation, broad formatting, and opportunistic cleanup increase review cost and risk. Brown-field work should be small, local, and unsurprising unless the user explicitly asks for a redesign.

**Core principle:** preserve working code. Change only what is necessary to satisfy the request.

## Use With Other Skills

- For bugs, test failures, or unexpected behavior: use `systematic-debugging` first to find root cause. Minimal editing controls the patch after you understand the failure.
- For post-change cleanup: use `simplify` only on code you just touched, and only if it preserves behavior.
- For refactors or deletion-oriented design review: use `reducing-entropy`; do not smuggle refactors into a bug fix.

## The Brown-Field Contract

When editing existing code, assume the current structure is intentional until evidence says otherwise.

Your job is to:

1. Understand the requested behavior change.
2. Identify the smallest code region that must change.
3. Preserve surrounding structure, names, formatting, and control flow.
4. Verify the behavior.
5. Leave optional cleanup as a separate recommendation, not a silent patch.

## Before Coding

### 1. Classify the task

Ask: is this green-field or brown-field?

- **Green-field:** creating new files/features from scratch. Minimal editing is less relevant.
- **Brown-field:** changing existing behavior. Minimal editing applies.

If the task is brown-field, continue.

### 2. Define the patch target

State the smallest intended change before editing:

- What behavior must change?
- Which file/function likely owns it?
- What nearby code must remain untouched?
- What test or check will prove the change worked?

If you cannot answer these, investigate more before patching.

### 3. Set a diff boundary

Decide what you expect the diff to contain. Examples:

- "One conditional in `parseDate`"
- "The SQL filter in `getActiveUsers` plus one regression test"
- "The prop mapping in `UserCard`, no styling changes"

This boundary is not bureaucracy. It gives you something to compare against after editing.

## While Coding

Prefer these moves:

- Change constants, operators, arguments, selectors, or conditionals before rewriting blocks.
- Add the narrowest regression test that captures the bug.
- Follow the surrounding style even if you personally prefer another style.
- Keep existing names unless the name is part of the bug.
- Keep existing function boundaries unless the boundary blocks the requested behavior.

Avoid these unless required by the request or root cause:

- Reformatting whole files.
- Renaming variables, functions, files, props, or tests.
- Extracting helpers.
- Adding broad input validation.
- Changing public APIs.
- Replacing loops with different iteration styles.
- Converting between libraries or framework patterns.
- "Improving" unrelated error handling.
- Touching adjacent code because it looks messy.

## When a Larger Patch Is Justified

Sometimes the smallest textual edit is not the smallest safe fix. A larger change may be right when:

- The root cause is an invariant violation, not a typo.
- A one-line fix would preserve known data loss, security risk, or broken API behavior.
- Existing structure makes the requested behavior impossible without changing boundaries.
- The user explicitly asked for cleanup, refactoring, redesign, or modernization.

When this happens, make the tradeoff explicit before or during the patch:

> A one-line fix is possible, but it would keep [risk]. I am making a larger change because [evidence]. I will keep it limited to [boundary].

If the larger change changes public behavior or broad architecture, ask the user before proceeding unless the request already authorizes it.

## After Coding: Diff Review

Before claiming completion, inspect the diff against your boundary.

For each changed hunk, ask:

1. Does this hunk directly serve the request?
2. Would the fix still work without it?
3. Did I change behavior that tests may not cover?
4. Did I increase cognitive complexity with new branches, nesting, helpers, or conversions?
5. Did I preserve project style?

If a hunk is not required, revert it. If it is useful but optional, remove it and mention it as follow-up.

## Completion Report

Keep the final report small and review-focused:

- What changed.
- Why that is sufficient.
- What verification ran.
- Any optional follow-up you intentionally did not include.

Example:

> Changed `range(len(items) - 1)` to `range(len(items))` in `summarize`. Added the regression case for a single-item list. Ran `pytest tests/test_summary.py`. I left the surrounding loop structure unchanged to keep the fix reviewable.

## Red Flags

Stop and shrink the patch if you catch yourself thinking:

- "While I'm here..."
- "This would be cleaner if I rewrote it."
- "The tests pass, so the larger diff is fine."
- "I renamed this for clarity."
- "I added validation just in case."
- "I changed formatting because the file was messy."
- "This helper may be useful later."
- "I don't fully understand why this works, but the rewrite passes tests."

## Quick Checklist

Before ending the turn:

- [ ] Root cause or requested behavior is understood.
- [ ] Patch is limited to the smallest necessary region.
- [ ] No unrelated cleanup, renames, formatting, or helper extraction slipped in.
- [ ] Diff was inspected after the last edit.
- [ ] Verification ran after the last edit.
- [ ] Larger-than-expected changes are justified explicitly.
