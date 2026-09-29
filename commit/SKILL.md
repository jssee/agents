---
name: commit
description: Commit changes as atomic commits. Use whenever committing, whether asked directly or finishing a change.
---

# Commit

Record the work as **atomic** commits: each one coherent change, staged exactly, with a subject that describes the diff.

- Ask before committing on `main` or `master`.
- Stage exactly the change. When a file mixes changes, stage hunks or lines with `scripts/hunk` (see `--help`). Leave unrelated work unstaged. When the work holds several changes, make several commits.
- Read the staged diff before committing.
- Make a normal commit by default. Use `--fixup=<sha>` only when the change corrects a mistake in one specific, unmerged commit on the current branch.
- Subject: match the repo's recent style; otherwise `<label>: <summary>` with `feat`, `fix`, `ref`, `docs`, or `chore`. It says what changed in the repo, not what prompted it.
- Add a body only for why. Reference issues only when the human supplied them. No AI attribution.
- Only add commits: amending, rebasing, resetting, and pushing are the human's call.
- When a hook fails, fix the cause and retry; hooks always run.
