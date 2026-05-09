# Skill House Rules

Use these rules when creating or revising skill instruction files in this directory.

## Purpose

Skills should be easy to follow under context pressure. Put invariant behavior first,
make the opening sufficient, and move reference material out of the main path.

## Critical Rules

- State the skill's primary purpose in the first 5-10 lines.
- Make the first 20-40 lines enough to execute the skill correctly.
- Separate mandatory rules from optional guidance.
- Use `must`, `never`, `prefer`, and `may` consistently.
- Put edge cases, examples, and rationale after the main workflow.
- Do not repeat the same rule in multiple sections.
- Do not assume optional tools, files, subagents, or other skills exist.
- Include exceptions when a rule could conflict with higher-priority instructions.
- Prefer short, high-signal instructions over complete documentation.

## Standard Structure

Use this outline for new skills and as the target shape for revised skills:

```md
# Skill: <name>
## Purpose
## Critical Rules
## When to Use
## When Not to Use
## Workflow
## Tool/File Handling
## Output Requirements
## Failure Handling
## Examples
```

Omit sections that do not apply, except `Purpose`, `Critical Rules`, and `Workflow`.

## Length Budget

- Target main `SKILL.md` length: 60-120 lines.
- Attention risk: over 150 lines.
- High risk: over 200 lines, especially with long examples or rationale.

Move this material to reference files:

- Long examples, case studies, transcripts, or historical notes.
- Research, background, or philosophy.
- Detailed command catalogs.
- Long troubleshooting trees.

## Wording and Priority

Use priority words deliberately:

- `must`: required unless higher-priority instructions conflict.
- `never`: safety or correctness invariant.
- `prefer`: default behavior with known exceptions.
- `may`: optional action.

Avoid brittle absolutes when exceptions are likely. Give the decision rule instead.

| Brittle | Better |
| --- | --- |
| `Always create a failing test before fixing.` | `Create or identify a failing reproduction before fixing when feasible. If not feasible, document why.` |
| `Reject any solution that adds code.` | `Challenge net code increases. Proceed only when added code is required.` |

## Workflow Requirements

A good workflow answers:

1. What should the model do first?
2. What evidence or inputs are required before action?
3. What tools or files should be used, if any?
4. What should happen after tool use?
5. What should the model output?
6. What should the model do when blocked or uncertain?

Keep workflows numbered, ordered, and action-oriented. Avoid long paragraphs.

## Tools and References

- Name required tools or files only when they are required.
- Say when a tool, file, or reference is optional.
- Include fallback behavior for missing tools, missing files, or ambiguous output.
- Do not reference external skills unless they are guaranteed to be available.
- Avoid project-specific assumptions such as `CLAUDE.md` unless the skill is project-specific.

## Examples

Examples illustrate rules; they must not define hidden requirements.

- Put examples after the workflow.
- Label examples clearly.
- Keep only the smallest useful example.
- Move extended examples to reference files.
- Do not let examples contradict the stated rules.

## Output and Failure Handling

Be explicit about final responses and blocked states. Specify when relevant:

- Required sections, citations, file paths, or naming conventions.
- Required verification results and skipped checks.
- Required changed-file, risk, or blocker notes.
- Whether to return final text only or include explanation.
- What to do if scope, tools, inputs, or expected behavior are unclear.

## Conflict Handling

Skills are lower priority than system, developer, user, and repo instructions. Write
rules with exceptions included when conflict is plausible.

Prefer: `Create a task branch when on main, unless the user or repo workflow says not to.`
Avoid: `Always create a branch from main.`

## Review Checklist

- [ ] Purpose appears in the first 5-10 lines.
- [ ] Critical rules appear before examples and rationale.
- [ ] Mandatory and optional guidance are distinguishable.
- [ ] Workflow is numbered and executable.
- [ ] Tool use and fallback behavior are clear.
- [ ] Output requirements are explicit.
- [ ] Edge cases come after the main workflow.
- [ ] Examples are short and clearly marked.
- [ ] Rationale and reference material are outside the main path.
- [ ] No rule relies on unstated assumptions.
- [ ] No wording conflicts with higher-priority instructions.
- [ ] Repeated rules are consolidated.
