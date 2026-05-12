# Cleanup Checklist

Run before declaring a diagnose session complete. Every item must pass.

- [ ] Original repro no longer reproduces (re-run the Phase 1 feedback loop, not just the regression test).
- [ ] Regression test passes — **or** the absence of a correct seam is documented in the commit/PR.
- [ ] All `[DEBUG-...]` instrumentation removed. Verify with a single `grep -r '\[DEBUG-' .` over the working tree.
- [ ] Throwaway harnesses, scratch scripts, and minimised repros deleted — or moved to a clearly marked debug location with a note explaining why they were kept.
- [ ] The winning hypothesis (the one that turned out correct) is stated in the commit or PR message. The next debugger should learn from it.
- [ ] If the root cause points at an architectural problem (no good test seam, tangled callers, hidden coupling), the specific finding is recorded as a follow-up — **after** the fix, not before.
