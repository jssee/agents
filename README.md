# agents

Agent skills, one per top-level directory with a `SKILL.md`.

`origin` pushes to GitHub and to the Amp personal skills repository, so one `git push` publishes to both. Amp loads the skills from the latter everywhere, including orbs. Other agents install from GitHub:

```sh
npx skills add jssee/agents          # project
npx skills add jssee/agents -g       # global
```

`tests/hunk.test.sh` tests `commit/scripts/hunk`.
