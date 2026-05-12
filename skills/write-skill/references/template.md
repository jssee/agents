# Skill Template

Use this template as the starting structure for new skills:

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

## Notes on Sections

- **Goal**: 1-3 sentences describing what the skill reliably produces.
- **Required Behavior**: Mandatory rules, constraints, decision points. Use `must`, `never`, `prefer`, `may` consistently.
- **Procedure**: Numbered, ordered, executable steps. Should be the main path.
- **When to Use / When Not to Use**: Clarify trigger boundaries and neighboring skills.
- **Tool/File Handling**: Address missing inputs, unavailable tools, fallback behavior.
- **Output Requirements**: Specify format, structure, citations, verification needs.
- **Failure Handling**: Cover blocked states, ambiguity, error recovery.
- **Examples**: Keep short; do not hide mandatory behavior only in examples.
