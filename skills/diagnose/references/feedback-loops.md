# Feedback Loop Techniques

A loop is fast, deterministic, agent-runnable, and produces a pass/fail signal for the specific reported failure. Try these roughly in order; pick the cheapest that fits.

1. **Failing test** at whatever seam reaches the bug — unit, integration, or e2e.
2. **Curl / HTTP script** against a running dev server.
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
4. **Headless browser script** (Playwright / Puppeteer) driving the UI and asserting on DOM, console, or network.
5. **Replay a captured trace.** Save a real network request, payload, or event log to disk; replay it through the code path in isolation.
6. **Throwaway harness.** Minimal subset of the system (one service, mocked deps) that exercises the bug code path with a single function call.
7. **Property or fuzz loop.** For "sometimes wrong output" bugs, run many random inputs and look for the failure mode.
8. **Bisection harness.** If the bug appeared between two known states (commit, dataset, version), automate "boot at state X, check, repeat" so `git bisect run` works.
9. **Differential loop.** Run the same input through old-version vs new-version (or two configs) and diff outputs.
10. **HITL bash script.** Last resort. If a human must click, drive *them* through a structured script so captured output still feeds back to the loop. Use `../scripts/hitl-loop.template.sh` as the starting point: copy it, edit the `step` and `capture` calls, run it, parse the final `KEY=VALUE` block.

## Iterating on the loop

Once you have *a* loop, treat it as a product:

- **Faster.** Cache setup, skip unrelated init, narrow the test scope.
- **Sharper.** Assert on the specific symptom, not "didn't crash."
- **More deterministic.** Pin time, seed RNG, isolate filesystem, freeze network.

A 30-second flaky loop is barely better than no loop. A 2-second deterministic loop is a debugging superpower.

## Non-deterministic bugs

The goal is not a clean repro but a **higher reproduction rate**. Loop the trigger 100×, parallelise, add stress, narrow timing windows, inject sleeps. A 50%-flake bug is debuggable; 1% is not — keep raising the rate until it is.

## When you genuinely cannot build a loop

Stop. List what you tried. Ask the user for one of:

- Access to an environment that reproduces the bug.
- A captured artifact (HAR file, log dump, core dump, screen recording with timestamps).
- Permission to add temporary production instrumentation.

Do **not** proceed to hypothesise without a loop.
