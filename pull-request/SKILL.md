---
name: pull-request
description: Present a change for easy review. Use when opening a pull request, or when a branch may need splitting into stacked PRs.
---

# Pull Request

A PR is judged by how easily it is **reviewed**: the reviewer knows why it exists, what it does, and can walk the log one commit at a time, judging each as a single concern.

Keep three units distinct:

- **Commit**: the unit of review. One concern, green on its own. Shape history with the `commit` skill.
- **PR**: the unit of merge. Everything that must land together.
- **Ticket**: the unit of planning. Map freely: one PR may close several tickets; a stack may serve one.

## Before opening

- Rebase onto the latest base branch.
- **Cold read** `git log --reverse <base>..` and each commit's diff as a reviewer seeing it first. Ready when every subject tells its step of the story, every diff does only what its subject says, and the order builds forward without backtracking.
- Run the repo's checks on the tip.

## Stacking

Default to one PR. Split into a **stack** (`gh stack`) only when a prefix of the commits is worth merging on its own: correct, useful, and safe to ship while the rest is in review. Length is a prompt to look for that seam, never a reason to split. Slice boundaries are natural seams.

## Title and body

- Title: imperative, in the repo's convention. A single-commit PR reuses the commit subject.
- Fill the repo's PR template when one exists.
- The body is a **briefing**, not a lab notebook. A reviewer holding the diff learns:
  - Why the change exists.
  - What it changes, in behaviour rather than files.
  - How to review it: where the risk is, what to read first.
  - How it was verified.
- Link tickets the human supplied. On GitHub each closing keyword closes one issue: `Closes #1, closes #2`. In a stack, only the PR that finishes a ticket closes it; earlier PRs say `Part of #1`.

## Media

Show visible changes so the reviewer sees the result without checking out the branch: screenshots, with a before when existing UI changes; video for interaction or motion. Attach with `gh pr create --attach`. `gh stack submit` cannot attach, so add media afterwards with `gh pr edit --attach`.

## Opening

Open as a draft: `gh pr create --draft`, or `gh stack submit --auto` (drafts by default).

Opening is the **handoff**: the human owns the PR from then on, including every push. Address review comments locally with the `commit` skill and leave the branch for the human to push.
