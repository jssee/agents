---
name: diagnose
description: Use when a bug, failure, exception, flake, or performance regression needs disciplined root-cause work. Triggers on "diagnose this", "debug this", "why is this broken/slow/throwing/failing", or any report of incorrect runtime behavior.
disable-model-invocation: true
---

# diagnose

## Goal

Reach a verified root cause and durable fix for hard bugs and performance regressions by working through a fixed loop: feedback loop → reproduce → hypothesise → instrument → fix → cleanup. The skill's leverage is in the feedback loop; later phases mechanically consume its signal.

## Required Behavior

- Must build a fast, deterministic, agent-runnable pass/fail signal before hypothesising.
- Must reproduce the **user's** reported failure, not a nearby look-alike, before proposing causes.
- Must generate 3–5 ranked, falsifiable hypotheses before testing any of them.
- Must change one variable per probe; never "log everything and grep."
- Must tag every temporary log with a unique prefix (e.g. `[DEBUG-a4f2]`) so cleanup is a single grep.
- Must verify the fix by re-running the original feedback loop, not only the regression test.
- Must remove all debug instrumentation and throwaway harnesses before declaring done.
- Must fix at the source of a bad value, not where it surfaces; trace backward through the call stack until causation, not just correlation, is established.
- Never propose a fix without a working feedback loop; if you cannot build one, stop and say so.
- Never write a regression test at a seam that does not exercise the real bug pattern; document the missing seam instead.
- Never attempt a fourth fix after three have failed on the same bug. Three strikes means the architecture, not the patch, is the problem — stop and surface that finding.
- Prefer debugger/REPL inspection over logs when the environment supports it.
- Prefer measuring (profiler, timing harness, query plan) over reading code for performance regressions.

## Procedure

1. **Build a feedback loop.** This is the skill — everything else mechanically consumes its signal.
   - **Before building anything, read the error and stack trace completely.** Note line numbers, file paths, error codes. The message often contains the exact cause; skipping past it wastes the next hour.
   - **Then check recent changes** with `git log --oneline -20` and `git diff` on the relevant paths. Recent diffs are the highest-prior hypothesis source and a free zeroth rung on the ladder.
   - Pick the cheapest technique that yields a deterministic pass/fail signal for the reported failure. See `references/feedback-loops.md` for the ranked ladder.
   - Iterate on the loop itself before using it: faster, sharper, more deterministic.
   - For non-deterministic bugs, the goal is a higher reproduction rate (loop the trigger, parallelise, inject sleeps), not a clean repro.
   - If no loop is achievable, stop. Ask the user for environment access, a captured artifact (HAR, log dump, core dump, recording), or permission to add temporary production instrumentation.

2. **Reproduce.** Run the loop and confirm:
   - The failure matches the **user's** description, not a nearby look-alike.
   - It reproduces across runs at a debuggable rate.
   - The exact symptom is captured (error message, wrong output, timing) so later phases can verify the fix.

3. **Hypothesise.** Write 3–5 ranked hypotheses before testing any of them.
   - Each must be falsifiable: *"If X is the cause, then changing Y will make the bug disappear / changing Z will make it worse."*
   - If you cannot state the prediction, discard or sharpen the hypothesis — it is a vibe.
   - Show the ranked list to the user before testing. They often re-rank instantly from domain knowledge.
   - Do not block on a reply; proceed with your ranking if the user is AFK.

4. **Instrument.** Test predictions, not vibes.
   - Each probe must map to a specific prediction from step 3.
   - Change one variable at a time.
   - Prefer a debugger breakpoint over logs when the environment supports it.
   - Tag every temporary log with a unique short prefix, e.g. `[DEBUG-a4f2]`, so cleanup is one grep.
   - **When the symptom appears deep in the call stack, trace the bad value backward to its source.** Ask: where did this value originate? What called this with it? Keep walking up until you find the layer that produced the wrong thing. Fix at the source, not where it surfaced — a symptom-site patch will mask the cause and reappear elsewhere.
   - For performance work, establish a baseline measurement first (profiler, timing harness, query plan) then bisect. Logs are usually the wrong tool.

5. **Fix and regression test.**
   - First check whether a *correct seam* exists — one where a test exercises the real bug pattern at the call site that triggered it.
   - If a correct seam exists: turn the minimised repro into a failing test there, watch it fail, apply the fix, watch it pass, then re-run the Phase 1 loop against the original un-minimised scenario.
   - If no correct seam exists, that absence is itself a finding. Record it in the commit/PR and apply the fix without a misleading test at the wrong seam.

6. **Cleanup and post-mortem.**
   - Run every item in `references/cleanup-checklist.md`.
   - State the winning hypothesis in the commit or PR message so the next debugger learns.
   - Then ask: *what would have prevented this bug?* If the answer is architectural, surface the specific finding as a follow-up — after the fix, not before, and do not block the fix on it.

## Tool/File Handling

- `references/feedback-loops.md` lists 10 techniques for constructing a pass/fail signal, in rough order of preference. Read it during step 1 when the right approach isn't obvious.
- `references/cleanup-checklist.md` is the verification gate for step 6.
- If the project has a domain glossary, ADRs, or architecture notes for the area you're touching, read them during step 1 to ground your hypotheses. Do not assume they exist.
- `scripts/hitl-loop.template.sh` is the last-resort harness for step 1 when a human must click. Copy it, edit the `step`/`capture` calls, run it, and parse the `KEY=VALUE` block it prints.

## Failure Handling

- **No feedback loop achievable.** Stop. List what you tried. Ask the user for environment access, a captured artifact, or permission to instrument. Do not proceed to hypothesise.
- **Repro doesn't match the user's report.** Treat it as a different bug. Re-read the user's description and adjust the loop before continuing.
- **All hypotheses falsified.** Generate a new ranked set informed by what the probes revealed. Do not start guessing.
- **Fix passes the regression test but the Phase 1 loop still fails.** The seam was wrong or the cause was misidentified. Return to step 3.
- **Three fixes have failed on the same bug.** Stop. Do not attempt a fourth. Pattern says the architecture is the problem, not the patch — each fix is revealing a new symptom because the underlying shape is wrong. Surface this to the user with the specific findings from the three attempts and ask whether to restructure before continuing.
- **Cleanup checklist fails.** Not done. Finish cleanup before declaring the work complete.
