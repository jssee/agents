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

## Template

```md
---
name: <skill-name>
description: <trigger-focused sentence describing when to use this skill>
---

# <skill-name>

## Goal
Required. State the outcome the skill should reliably produce in 1-3 sentences.

## Required Behavior
Required. List mandatory behavior, constraints, and decision rules.

## Procedure
Required. Provide the ordered main path the agent should follow.

## When to Use
Optional. Include when triggers or neighboring-skill boundaries need clarification.

## When Not to Use
Optional. Include when exclusions or common misuses need clarification.

## Tool/File Handling
Optional. Include only when tools, files, references, or fallback behavior matter.

## Output Requirements
Optional. Include only when final format, paths, citations, verification notes, or summaries matter.

## Failure Handling
Optional. Include only when missing inputs, failed tools, ambiguity, or blocked work are likely.

## Examples
Optional. Keep minimal. Do not place mandatory behavior only in examples.
```

## Length and References

- Target `SKILL.md` length: 75-150 lines.
- Prefer 75-120 lines for simple skills.
- Review carefully when over 150 lines.
- Avoid exceeding 200 lines unless the skill genuinely needs the extra structure.
- The first 20-40 lines must contain the operational core.

Move material to reference files when it is useful but not needed for the main path:

- long examples or transcripts,
- detailed troubleshooting trees,
- command catalogs,
- background, rationale, or design philosophy,
- large tables or compatibility matrices,
- rare edge cases,
- tool-specific details that only apply conditionally.

Reference files should be named explicitly and read only when relevant.

Prefer:

```md
Read `references/troubleshooting.md` only if the main procedure fails or the error matches a known failure pattern.

## Review Checklist

- [ ] YAML front matter includes `name` and `description`.
- [ ] `name` matches the skill directory name.
- [ ] `description` is trigger-focused.
- [ ] Required sections are present: `Goal`, `Required Behavior`, and `Procedure`.
- [ ] `SKILL.md` is within 75-150 lines, or extra length is justified by execution needs.
- [ ] Reference files are used for long examples, rare edge cases, background, or conditional details.
- [ ] Reference files are named explicitly and read only when relevant.
- [ ] First 20-40 lines contain the operational core.
- [ ] Mandatory and optional guidance are distinguishable.
- [ ] Procedure is numbered, ordered, and executable.
- [ ] Tool/file assumptions and fallbacks are clear when relevant.
- [ ] Output requirements are explicit when format or verification matters.
- [ ] Failure handling is explicit when blocked states are likely.
- [ ] Examples are short and do not contain hidden requirements.
- [ ] Repeated rules and long rationale are removed.
