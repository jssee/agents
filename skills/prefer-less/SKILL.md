---
name: prefer-less
description: Use when editing existing code, polishing a recent diff, or evaluating a design. Bias toward less code and fewer concepts within the requested scope. Triggers on bug fixes, PR feedback, pre-commit cleanup, refactor decisions, and "is this worth the complexity" questions.
---

# prefer-less

## Goal

Every change should avoid unnecessary code and concepts. Prefer leaving the codebase smaller when that preserves clarity, behavior, and the requested outcome. When more code is required, keep the addition as small as the request allows.

## Required Behavior

- Must stay inside the scope the user actually asked for.
- Must measure success by the codebase's end state, not by patch effort or familiarity.
- Must inspect the final diff hunk by hunk and revert hunks not required by the request.
- Prefer deletion, inlining, or making code obsolete when end-state is smaller.
- Prefer keeping abstractions that earn their cost; never inline just to reduce lines.
- Must preserve exact behavior in polish mode unless the user asked for a change.
- Must challenge net code increases; proceed only when added code is required.
- Never rewrite working untouched code as a side effect of another task.
- Never use passing tests to justify unrelated rewrites.
- Never add flexibility, layers, or types without a concrete expected use.
- Never treat fewer lines as proof code is simpler; clarity wins ties.

## Procedure

1. Identify the context. Pick one:
   - **Editing** — fulfilling a request that modifies existing code.
   - **Polishing** — pre-commit cleanup of a recent diff.
   - **Designing** — evaluating a proposed approach, refactor, or new code.

2. If **Editing**:
   - Define the smallest patch boundary that satisfies the request (one conditional, one argument, one call site, one branch + one test).
   - Prefer local edits over rewrites.
   - Skip unrelated cleanup, renames, formatting churn, helper extraction.
   - If the boundary must grow, pause and justify why a smaller patch is unsafe.

3. If **Polishing**:
   - Touch only recently changed code.
   - Preserve behavior, public APIs, data shapes, and side effects.
   - Look for nested conditionals, duplicated logic, unclear names, obvious comments, one-off abstractions that hide intent.
   - Keep abstractions that earn their cost; do not merge code only to shorten it.

4. If **Designing**:
   - Load one mindset from `references/*.md` and state it in one sentence.
   - Describe the current end-state and the proposed end-state.
   - Identify what the change adds: files, functions, concepts, dependencies, configuration, branches.
   - Identify what can be deleted, merged, avoided, or made obsolete.
   - Compare end-states by total code and concepts, not patch size.
   - Name any addition justified because it is expensive to retrofit.

5. After any context:
   - Inspect the final diff.
   - Revert unrelated cleanup, formatting churn, and behavior changes.
   - Run the narrowest relevant verification available.

## When Not to Use

- The user explicitly asked for additive exploration, prototyping, or rewriting.
- The user is asking for a first draft of new functionality and has not asked to optimize for minimality.
- Framework, compatibility, or regulatory constraints require the structure.
- Pure formatting work the repo requires.

## Tool/File Handling

- Use `references/*.md` only in design mode, for mindset selection. See `references/` for: data-oriented design, composition over construction, PAGNI, simplicity vs. easy.
- If references are unavailable, continue without them and note the gap.
- Do not run formatters that rewrite unrelated code unless the repo requires it.

## Output Requirements

Final response must include:

- Which context applied (editing, polishing, or designing).
- What changed or what was recommended.
- For design mode: loaded mindset, end-state comparison, recommendation.
- Verification ran or skipped.
- Any larger-than-expected change and why it was necessary.

## Failure Handling

- If the requested behavior is unclear, ask one narrow question.
- If a smaller patch cannot satisfy the request, name the constraint and the smallest compliant version.
- If polish would require touching untouched code, ask before expanding scope.
- If deletion would break required behavior, recommend the smallest safe reduction.
- If the final diff exceeds the expected boundary, shrink it or explain the evidence that makes the larger patch necessary.
