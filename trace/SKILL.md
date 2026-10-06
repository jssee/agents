---
name: trace
description: Trace a proposed change through the existing code to ground it before building.
---

# Trace

Check a proposed change against the existing code. Treat any proposal as a **hypothesis**: unchecked plans can duplicate existing abstractions.

Read and run code freely. Remove any temporary instrumentation before reporting.

1. List what **must become true** for the proposed behavior to work. If the proposal is too vague, ask the one question that determines which mechanisms matter.
2. For each condition, find the **mechanism** responsible today. Follow every path that touches it; the second consumer is the one usually missed. If nothing exists, name what must be built and what it connects to.
3. Give each mechanism a verdict: **reuse**, **extend**, **refactor**, or **build new**. Cite **precedent**: similar problems the codebase has solved.
4. Where the change conflicts with the architecture or the code contradicts the proposal, name the **pressure point** and give a one-line alternative. If the conflict invalidates the direction, stop and report.

Finish when every condition maps to a mechanism or an explicit unknown.

Support every observation with a **pointer**: `file:line`, symbol, or command output. Label claims without pointers as inferences.

Report:

- **Ready** if no unknown would change the approach; name any risks. Otherwise, **Not ready**; name what is needed: an answer, an experiment, or a different direction.
- Condition → mechanism → verdict → change.
- Unknowns.
