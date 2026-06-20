---
name: commit
description: Commit one clean repo change. Use when asked to commit, save local changes, or handle review fixes; enforce scope, stage, fixup, and subject gates.
---

# commit

## Goal

Create one clean commit: one related repo change, staged deliberately, with the right commit kind and a diff-based subject.

Review feedback is a fixup signal, not a subject. If the change repairs, refactors, or completes earlier work on this branch, make a fixup commit.

## Hard Rules

- Never commit on `main` or `master` without asking.
- Stage explicit in-scope files only; never use `git add .`, `git add -A`, or `git add -p`.
- Never amend, rebase, squash, reset, push, or force-push.
- Never bypass commit hooks.
- Never add AI attribution.
- Do not pass a gate while scope, fixup target, or subject is unclear; ask.

## Protocol

1. Inspect.
   - Check branch, status, recent log, unstaged diff, and staged diff.
   - Stop and ask if on `main` or `master`.

2. Scope gate: one change.
   - Choose one related repo change.
   - Leave unrelated work unstaged; ask if unrelated changes share a file with intended work.

3. Stage gate: exact diff.
   - Stage explicit files only.
   - Inspect the staged diff.
   - Proceed only when the staged diff exactly matches the intended commit.

4. Fixup gate: repair previous work.
   - Check whether the staged diff repairs, refactors, or completes earlier branch work; use recent history and path history as needed.
   - If yes, commit with `git commit --fixup=<sha>` and skip the subject gate.
   - If the target is unclear or multiple targets fit, ask or split.

5. Subject gate and commit.
   - If no fixup applies, make one normal commit.
   - For normal commits, the subject describes the diff, not the prompt, review, chat, or workflow.
   - Match recent commit style when consistent; otherwise use `<label>: <summary>` as the subject.
   - Valid labels: `feat`, `fix`, `ref`, `docs`, `chore`.
   - Use imperative mood in the summary: `fix: handle parser crash`, not `fix: handled parser crash`.
   - Test the summary with: “If applied, this commit will <summary>”.
   - The subject must answer: “What changed in the repo?”
   - Bad: `fix: address review comments`, `fix: apply feedback`, `update changes`, `misc`, `wip`.
   - Add a body only for why/context; the diff explains how. Add issue references only when the user supplied them.

6. Finish clean.
   - If a hook fails, read the output, fix in scope or ask, then retry.
   - Verify status after the commit.
   - Report details only for multiple commits, failed or skipped verification, or remaining work.
