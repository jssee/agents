---
name: surgical-editing
description: Surgical editing. Use when modifying existing code where a small local patch should satisfy the request.
---

# surgical-editing

## Intent

Produce surgical patches: the smallest behavior-correct change inside the user's request.

## Procedure

1. Choose the current cut: the smallest area that can satisfy the next behavior change.
   - Cut examples: one condition, one call site, one argument, one function, one test, one module seam.
   - Also identify whether the cut crosses a trust boundary: where untyped, external, or user-controlled data enters typed code.
   - Keep the cut private unless it expands, is ambiguous, or affects a trust boundary.

2. Edit inside that cut first.
   - Prefer local edits over rewrites.
   - Do not armor typed internals. Avoid `isRecord`, `isString`, broad `try/catch`, fallback defaults, retries, or defensive branches unless the cut crosses a trust boundary or the requested behavior requires recovery; at a trust boundary, prefer an existing parser, schema, or typed API and parse once.
   - Do not rename, reformat, extract helpers, add types, add config, or clean up nearby code unless the request requires it.
   - Complete when the requested behavior is implemented or you have evidence the cut is too small.

3. If the cut grows, justify it before continuing.
   - Allowed reasons: shared bug source, required API contract, failing test evidence, or an unsafe partial fix.
   - Complete when the new cut is the smallest one that satisfies the request.

4. Audit the final diff hunk by hunk.
   - Revert unrelated cleanup, formatting churn, speculative flexibility, and behavior changes outside the request.
   - Keep added code only when deletion would break the requested behavior.
   - Complete when every hunk is necessary for the request.

## Rules

- Surgical means every hunk has a narrow reason, not that the whole feature is tiny.
- Surgical means fewer concepts, not fewer lines. Clarity beats compression.
- Parse once at trust boundaries; do not validate already-typed internals.
- Armor belongs only at trust boundaries or required recovery paths.
- Preserve existing behavior except for the requested change.
- Ask one narrow question if the requested behavior or cut is unclear.