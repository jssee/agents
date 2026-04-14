---
name: shaping
description: Use when defining what to build and why. Separates problems from solutions, evaluates options with binary fit checks, and produces a lightweight shaping doc. User can choose to opt out of this approach.
---

# Shaping

## Overview

Shaping is thinking before building. It answers two questions:

1. **What problems are we solving?** (Requirements)
2. **What solutions are possible?** (Shapes)

**Core principle:** Problems and solutions are different things. Name them separately. Evaluate them against each other.

## When to Use

- Starting a new feature or project
- Unclear what to build or which approach to take
- Multiple possible solutions and no clear winner
- Need to scope work before committing to an approach

**Not for:** Work where the problem and solution are both obvious. Just build it.

## The Conversation

Shaping is a conversation, not a document-generation exercise. Your job is to be a thinking partner:

- Ask questions that expose hidden requirements
- Push back on vague problem statements — "what specifically hurts?"
- Propose concrete solution mechanisms, not intentions
- Challenge shapes that sound good but don't actually address requirements
- Surface tradeoffs the human hasn't considered

**Questions before shapes.** Before proposing any shapes, ask the questions you need answered. Do this in a single focused message — not a wall of questions, but the 2–3 that would most change what you build. Wait for answers. A shape presented before the problem is understood will be revised anyway, and forces the human to read and react to something premature.

**Don't rush to document.** Think first, write when the picture is clear enough to be useful.

## Requirements (R)

Requirements describe **what's needed**, not what satisfies it.

- Numbered: `R0, R1, R2…` — max 9 top-level
- Each has a status: `core | must | nice | out`
- A requirement states a problem or constraint, never a solution
- If a requirement sounds like a solution, there's a hidden problem underneath — find it

| ✅ Requirement | ❌ Not a requirement |
|---|---|
| "Users need to find items quickly" | "Add a search bar" |
| "State must survive page refresh" | "Use localStorage" |
| "Admins need to see who changed what" | "Add an audit log table" |

**Negotiate status.** Not everything is `must`. Ask: "What happens if we don't do this?" If the answer is "it's fine for now," that's `nice` or `out`.

## Shapes (A, B, C…)

Shapes are mutually exclusive solution approaches. Only present shapes that are genuinely viable — ones that could actually be chosen. **One strong shape is better than three where two are filler.** There is no minimum.

- Lettered: `A, B, C…`
- Each shape is a short list of **mechanisms** — concrete things you build or change
- Mechanisms describe *what*, not *why* (requirements already cover *why*)
- If two shapes share most mechanisms, they're not different shapes — they're variants of one shape
- All presented shapes get the same level of thought and detail. If a shape doesn't deserve that, it's not a real shape — drop it

**Parts must be mechanisms:**

| ✅ Mechanism | ❌ Not a mechanism |
|---|---|
| "URL query params store filter state" | "Make it fast" |
| "Server-side search with debounced input" | "Good search experience" |
| "Webhook fires on record change" | "Keep systems in sync" |

If a shape part restates a requirement in different words, it adds no information. Delete it.

## Fit Check

The decision tool. A matrix of Requirements × Shapes.

```markdown
| Req | Requirement | Status | A | B | C |
|-----|-------------|--------|---|---|---|
| R0  | Find items quickly | core | ✅ | ✅ | ✅ |
| R1  | State survives refresh | must | ✅ | ❌ | ✅ |
| R2  | Works offline | nice | ❌ | ❌ | ✅ |
```

**Rules:**

- **Binary only** — ✅ or ❌. Never "partially" or "with some work." It either addresses the requirement or it doesn't.
- If you don't know whether a shape addresses a requirement, that's ❌. Uncertainty is not a pass.
- If a shape passes all checks but feels wrong, there's a missing requirement. Articulate it, add it, re-run the check.
- `nice` and `out` requirements don't disqualify a shape, but they inform the decision.

## Output

When shaping is done, ask the user where the artifacts should live:

- **Create `shape.md` in the repo** — lightweight working doc, not a specification
- **Other** — the user may prefer an external tool (task tracker, wiki, etc.). Summarize the shaping output in whatever format they need so they can capture it themselves.

If writing `shape.md`, use this as a starting point — not a mandate. Use what's useful, skip what isn't. The fit check table is the one non-negotiable — it's where thinking becomes visible.

```markdown
# [Project Name] — Shape

## Problem
2-3 sentences. What hurts, what does good look like.

## Requirements
| # | Requirement | Status |
|---|-------------|--------|

## Shapes
### Shape A: [Name]
- mechanism 1
- mechanism 2

### Shape B: [Name]
- mechanism 1
- mechanism 2

## Fit Check
| Req | Requirement | Status | A | B |
|-----|-------------|--------|---|---|

## Decision
[Which shape and why. 1-2 sentences.]
```

## Red Flags

- **Presenting shapes before asking questions** — if the problem isn't understood, the shapes will be wrong. Ask first.
- **Shape padding** — weak alternatives included just to have multiple options. If a shape couldn't realistically win, it shouldn't be there. Drop it.
- **Uneven shape development** — one shape with a detailed mechanism list, others with one vague line. This signals a foregone conclusion. Either develop all shapes properly or remove the weak ones.
- **Requirements that are solutions in disguise** — find the problem underneath
- **Shapes that are identical except for one detail** — that's one shape with a decision point, not two shapes
- **"We need all of these"** — if everything is `must`, nothing is prioritized. Push back.
- **Fit check with all ✅** — either the shapes aren't different enough or requirements aren't specific enough
- **Giant requirements list** — if you have more than 9, you're solving multiple problems. Split them.
- **Premature detail** — shaping decides *what* and *which approach*, not *how exactly*. Implementation details belong in slicing.
