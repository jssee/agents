---
name: commit
description: Use when committing local changes while preserving clean, reviewable git history.
---

# commit

## Goal

Preserve pristine, reviewable git history. Commit only related work. Use fixup
commits when the change repairs, refactors, or completes earlier work on this branch.

## Required Behavior

- Never use `git add .` or `git add -A`.
- Stage explicit files only; never use interactive staging such as `git add -p`.
- Run the fixup gate before every normal commit.
- Use `git commit --fixup=<sha>` when the change fixes, refactors, or completes a previous commit on this branch.
- Make a normal commit only for an independent new reviewable decision.
- If the fixup target is unclear, ask.
- If changes map to multiple commits, split them or ask.
- Never commit on `main` or `master` without asking.
- Never amend, rebase, squash, reset, push, or force-push. The user handles history cleanup and publishing.
- Match existing style for normal commits; never add AI attribution.
- Do not commit known-broken work unless the user approves.

## Procedure

1. Inspect state:
   - `git branch --show-current`
   - `git status --short --branch`
   - `git log --oneline -10`
2. If on `main` or `master`, stop and ask before committing.
3. Review unstaged and staged work:
   - `git diff --stat`
   - `git diff`
   - `git diff --cached`
4. Stage only explicit in-scope files. Never use `git add .`, `git add -A`, or `git add -p`.
5. Verify staged content is exactly what you intend to commit:
   - `git diff --cached --stat`
   - `git diff --cached`
   - If anything unexpected is staged, unstage it before continuing.
6. Run the fixup gate:
   - Check recent commits with `git log --oneline -10`.
   - For staged paths, check `git log --oneline -- <path>` when useful.
   - State: which prior commits (if any) touch the same concern as this diff, and whether this change repairs, refactors, or completes one of them.
7. If yes and the target is clear, run `git commit --fixup=<sha>`.
8. If yes but unclear, ask. If there are multiple targets, split or ask.
9. If no, make one normal commit using existing style.
10. Verify with `git status --short --branch` and `git show --stat --oneline HEAD`.

## Normal Commit Style

- Look at the last 5–10 commit subjects. If they share a format (e.g., `type(scope): msg`,
  `[TAG] msg`, sentence case with no prefix), use that format exactly.
- If no consistent pattern exists, use `<label>: <subject>` with one of:
  - `feat`: new user-visible behavior
  - `fix`: correction to broken behavior
  - `ref`: behavior-preserving restructuring
  - `docs`: documentation-only changes
  - `chore`: maintenance or other work
- Keep the subject short, imperative, and without a final period.
- Add a body when the subject alone doesn't explain *why* the change was made. Omit the body when the subject + diff are self-explanatory.
- Add issue references only when the user supplied them.

## Failure and Output

- If unrelated work is present, leave it unstaged and mention it.
- If unrelated changes share a file with intended work, ask the user to split or stage it.
- If a commit hook fails, read the output; fix in scope or ask. Do not bypass hooks.
- If verification failed or was not run, say so.
- Report commit hash and subject, normal vs. fixup, verification, skipped checks, and remaining uncommitted changes.
