---
name: opening-pull-requests
description: Prepares reviewable pull requests with clean commit history and explicit publication boundaries. Use when preparing, opening, or formatting a pull request.
---

# Opening Pull Requests

Prepare an easily reviewable change; do not mistake readiness for permission to publish it.

## Reviewability

- Work on a dedicated branch. Commit coherent units as work progresses, before review; use the `commit` skill for atomic history and fixups.
- Judge batching by the user's criterion: “will this batch produce an easily reviewable PR?” Keep unrelated work out of the proposed PR.
- Keep commits individually reviewable. Fold corrections into their owning local commits instead of appending fix commits; preserve the final implementation when rewriting history.
- Before proposing the PR, inspect the full diff and commit sequence against the intended base, verify the affected behavior, and report any verification limits honestly.

## Title and body

The source conversations do **not** establish personal PR title or body formatting preferences. Do not convert commit-message rules into PR-title rules or invent a mandatory template, tone, length, checklist, ticket prefix, or section order.

- Follow any explicit instructions for the current PR and applicable repository guidance/template. Where neither specifies formatting, use a plain factual title and description as an ordinary drafting choice, not an attributed personal preference.
- Describe the actual change and actual verification; do not claim checks, publication, or deployment that did not happen.
- Do not infer a PR-body linking requirement from a request to include Linear links in a child-thread brief.

## Authorization

- Preparing a local branch, commits, and a proposed title/body is not permission to push or open a PR.
- Require explicit authorization for pushing and opening the PR. Carry existing authorization forward only within its stated scope; do not ask again for an action already authorized.
- “Ready to open a PR” or a request to review readiness is not an instruction to open it. Likewise, approval to split or fix up local commits does not authorize publication.
- Permission to push does not by itself authorize opening a PR; permission to open a PR does not authorize merging or deploying. If opening requires a push not already authorized, finish local preparation and request that remaining authorization together with the proposed PR.
- Never rewrite published history without explicit approval.
- When authorization is missing, present the proposed PR and name the exact remaining action and destination. Once authorized, perform that action and report its actual outcome.

## Instruction provenance

These are human instructions, not assistant-generated delegation rules:

- [VetterCare papa thread](https://ampcode.com/threads/T-01a0f044-8ded-730e-b8bf-c063aa7f2558): “will this batch produce an easily reviewable PR?”; “agent should commit the work as it works, certainly before review, so that we can track it more easily. Let’s make sure the work is committed to history before we review it.”; “and they should create a branch for their work too”.
- [VETTER-197 child](https://ampcode.com/threads/T-01a0f2a9-fead-7696-9206-107d54d93f24): “is this really the most atomic representation of these changes? feels like a fat commit, hard to review”; “feels like the history here can be more pristine, why are we appending fix commits instead of fixing up the changes?” The subsequent approvals applied to those local history changes, not publication.
- [Skills-improvement thread](https://ampcode.com/threads/T-01a0f411-571d-7429-b548-c5c5b732264f): “make a branch for these edits first”. This applied to those skill edits and did not authorize a push or PR. No PR title/body formatting instruction was found in this or the two implementation threads.

The authorization section preserves the existing personal guidance to confirm remote writes. One-off instructions to rebase a particular branch or perform a retrospective before a particular PR are not universal PR prerequisites.
