---
name: commit
description: Maintain pristine, atomic history. Read before running `git add` or `git commit`, or rewriting commits.
---

# Commit

Maintain **pristine, atomic history**. Rewrite it freely; never push without explicit permission.

- Stage hunks or lines across files with `sh scripts/hunk` (see `--help`).
- Fold corrections into their original commit with `git history fixup <commit>`.
- Correct messages with `git history reword <commit>`. Separate mixed commits with `git history split <commit>`.
- For commands that open an editor, set `GIT_EDITOR` (or `GIT_SEQUENCE_EDITOR` for rebase todo lists).
- Resolve obvious conflicts without asking; ask when what to preserve is unclear.
- Match the repo's recent commit style; otherwise use `<label>: <summary>` with `feat`, `fix`, `ref`, `docs`, or `chore`. Write an imperative summary that completes: “If applied, this commit will <summary>.”
- Add a body only for why. Reference issues only when the human supplied them. Omit AI attribution.
- Run relevant checks after each commit or rewrite; `git history` skips hooks, so run them yourself. Never bypass hooks (`--no-verify`, `-n`). Report failures.
- Finish with all intended changes committed and unrelated work preserved.
