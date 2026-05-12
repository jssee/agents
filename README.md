# Agents Repository

This repository contains the core skills and configuration for our agent ecosystem.

## Skills

Skills define specialized, reusable capabilities for the agent.

- **`commit`**: Preserves clean, reviewable git history. Use for committing related work.
- **`prefer-less`**: The unified skill for bias-toward-simplicity. Handles three contexts:
  - **Editing**: Small-patch discipline for existing code.
  - **Polishing**: Behavior-preserving pre-commit cleanup.
  - **Designing**: Strategic evaluation of designs/refactors using mindset references.
- **`shaping`**: Aligns fuzzy ideas before implementation (clarification → requirements → shapes → fit-check → recommendation).
- **`slicing`**: Sequences work into small, demo-able vertical slices.
- **`write-skill`**: Standardizes the creation and auditing of new skills using templates and checklists.

## Development

- **Adding a new skill**: Use the `write-skill` meta-skill to generate the initial structure and audit the final result.
- **Updating a skill**: Ensure adherence to the current `write-skill` standards and line count targets.
