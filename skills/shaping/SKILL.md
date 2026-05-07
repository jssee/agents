---
name: shaping
description: Use when working through a fuzzy idea before implementation. Helps the agent and user get aligned on the problem, constraints, tradeoffs, and likely approach. Use for prompts like "not sure which approach", "should we build X or Y", "what's the scope", "tradeoffs", "before we start", or whenever multiple viable directions exist and none is obviously right. Pair with `slicing` after an approach is selected.
---

# Shaping

Use this skill to get alignment before building.

## Goal

Help the user move from a fuzzy idea to a shared understanding of:

1. what problem matters;
2. what constraints shape the work;
3. which approaches are viable;
4. what direction seems best.

Do not default to producing a formal document. Keep the interaction conversational and lightweight unless the user asks for a written artifact.

## Operating rules

- Separate problems from solutions.
- Ask a few clarification questions only when the answers would materially change the direction.
- If the request has multiple plausible interpretations, ask before shaping.
- If enough context exists, state assumptions and proceed.
- Prefer making progress over stalling for perfect clarity.
- Do not force multiple approaches; one strong approach is fine.
- Do not invent weak alternatives just to compare something.
- If everything feels like a `must`, push for priority.
- If an approach seems wrong despite fitting the stated needs, name the missing requirement or concern.

## Conversation pattern

Adapt to the situation. Use only the parts that help alignment.

### Assumptions

Briefly state what you think the user is trying to achieve, who it serves, key constraints, and likely hidden complexity.

### Questions

Ask only the 2–5 questions that would most change the direction.

Skip this if you can make reasonable assumptions.

### Requirements

Capture the important needs as `R0`, `R1`, `R2`, up to 9 total.

Each requirement should include a status:

- `core`: central to the goal
- `must`: required for this version
- `nice`: useful but not required
- `out`: explicitly not in scope

Requirements describe the problem or constraint, not the solution.

Good: “Users need to find items quickly.”

Bad: “Add a search bar.”

### Shapes

When there are multiple viable directions, label them `A`, `B`, `C`.

Each shape should describe concrete mechanisms: what would be built or changed.

Rules:

- Only include shapes that could realistically win.
- If two shapes mostly overlap, combine them and call out the decision point.
- Keep approaches similarly detailed.
- Mention rejected directions briefly only when useful.

### Fit check

Use a binary fit check when comparing approaches would clarify the decision. The fit check table is the one non-negotiable — it's where thinking becomes visible.

| Req | Requirement | Status | A | B | C |
|-----|-------------|--------|---|---|---|
| R0 | Example requirement | core | ✅ | ❌ | ✅ |

Rules:

- Use only ✅ or ❌.
- Unknown counts as ❌.
- `core` and `must` failures usually disqualify an approach.
- `nice` and `out` inform the decision but do not decide it alone.

### Alignment

End by stating the current best direction and what needs agreement next.

Keep this short:
- recommended direction;
- why it fits;
- what decision or uncertainty remains.
