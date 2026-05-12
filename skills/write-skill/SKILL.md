---
name: write-skill
description: Create or revise SKILL.md instruction files that agents can follow reliably under context pressure.
---

# write-skill

## Goal

Create or revise short, executable `SKILL.md` files that agents can follow reliably under context pressure. Each skill should define its outcome, required behavior, main procedure, assumptions, outputs, and failure handling.

## Required Behavior

- Keep every skill focused on one reusable capability.
- Include YAML front matter with `name` and a trigger-focused `description`.
- Keep `Goal`, `Required Behavior`, and `Procedure` in every skill.
- Make the first 20-40 lines enough to understand when to use the skill, what it must do, and what it must not do.
- Target 75-150 lines for `SKILL.md`; move reference material out of the main path.
- Separate mandatory behavior from optional guidance.
- Use `must`, `never`, `prefer`, and `may` consistently.
- Put exceptions next to the rule they modify.
- Do not assume optional tools, files, subagents, project conventions, or other skills exist.
- Include fallback behavior when missing inputs, unavailable tools, or ambiguity are likely.
- Put examples and rationale after the main procedure, or omit them.

## When to Use

Use this skill to create, revise, compress, audit, or refactor an agent skill file.

Do not use it for ordinary prose, code, documentation, or prompts that are not meant to become reusable agent skills.

## Procedure

1. Identify the skill boundary.
   - Determine the trigger, expected inputs, required behavior, outputs, and failure modes.
   - Split unrelated or broad behavior into separate skills.

2. Draft the required sections first.
   - Start with `Goal`, `Required Behavior`, and `Procedure`.
   - Make the procedure numbered, ordered, and action-oriented.
   - Reference the template in `references/template.md` to ensure consistent structure.

3. Add optional sections only when they clarify execution.
   - Use `When to Use` or `When Not to Use` for boundaries.
   - Use `Tool/File Handling` for tool, file, reference, or fallback assumptions.
   - Use `Output Requirements` when response format, paths, citations, summaries, or verification matter.
   - Use `Failure Handling` when blocked states are likely.
   - Use `Examples` only for the smallest useful examples.

4. Review and compress.
   - Remove duplicate rules, rationale, commentary, and hidden assumptions.
   - Move long examples, command catalogs, troubleshooting, and background to reference files.
   - Check that required behavior appears in rules, not only in examples.
   - Use the checklist in `references/review-checklist.md` to verify the skill is complete.

## Tool/File Handling

Read `references/template.md` to see the standard skill structure and section descriptions. Use it as a starting point for every new skill.

Read `references/review-checklist.md` before finalizing a skill. It covers YAML structure, length, reference files, procedure clarity, and other execution requirements.

## Output Requirements

Final response must include:

- The new or revised `SKILL.md`.
- Any required reference files for examples, mindsets, checklists, templates, or background.
- A summary of structure and length.

## Failure Handling

- If the skill boundary is unclear, ask clarification questions before drafting.
- If the skill exceeds 200 lines, identify what can move to reference files.
- If required sections are missing, add them before considering the skill complete.
