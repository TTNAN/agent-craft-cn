**简体中文** | [English](README_en.md)

# agent-craft-cn

![version](https://img.shields.io/badge/version-v0.2.0-blue) ![license](https://img.shields.io/badge/license-MIT-green) ![skills](https://img.shields.io/badge/skills-9-orange)

**A Chinese-native collection of agent skills for software development methodology: teaching your AI coding assistant to work like a senior engineer.**

## Why you need it

The problem with AI coding assistants today isn't that they can't write code — it's that **they don't work like senior engineers**:

- You say "add an export feature", it churns out 200 lines of Excel export, you say "I wanted CSV" — **it started coding before understanding**, and rework costs 3x the first attempt
- A production bug appears, it goes "let me try changing this and see" — three changes later the bug is still there and the code is messier. **Debugging by luck**, root cause unknown
- You ask it to review code, it says "looks good overall, a few nits: rename `u` to `user`" — **review theater**, while real issues (SQL injection, N+1) go unnoticed
- After the project ships you ask for a retro, it writes "thanks to everyone's joint efforts, complete success" — **a praise report**, so the same mistakes repeat next time

These aren't model capability problems — they're a **missing methodology**. The first thing a senior engineer does when mentoring a newcomer is set the rules: clarify requirements first, plan before coding, tests first, report only real issues in review, reproduce before debugging. This pack turns those rules into 9 skills installed into your AI.

## What it is

9 Chinese-native skills covering one complete development cycle:

- **using-agent-craft** (orchestrator): read me first on any task — assembles the right workflow per task size; S-size tasks are nearly invisible, L-size tasks get the full pipeline
- **clarify-first**: requirement clarification — one question at a time, don't start until it's actionable
- **plan-before-code**: plan before coding — goal/steps/risks/verification, user approves before you code
- **tdd-red-green**: test-driven development — red → green → refactor, the order is non-negotiable
- **review-five-axes**: five-axis code review — only real issues, no padding
- **debug-like-detective**: systematic debugging — reproduce → hypothesize → minimal experiments → binary search
- **refactor-small-steps**: small-step refactoring — every step verifiable and rollback-safe
- **write-chinese-docs**: Chinese technical writing — plain language, no translationese, no AI slop
- **retrospective**: postmortems — facts → root causes → actionable items

The English-speaking world has superpowers; this pack is **written from scratch in Chinese**, plus things superpowers doesn't have: an orchestrator skill (workflows by task size, not everything at once), AI-countable thresholds (no "no progress for 30 minutes", which an AI can't feel), and Chinese technical-writing conventions.

## Who it's for

Chinese developers who write code daily with Claude Code, Cursor, Codex, or Gemini CLI. No learning curve — you keep asking the way you always do, and the AI follows the rules at the right moments.

Current version: **v0.2.0** (see [CHANGELOG](./CHANGELOG.md))

## Contents

- [Why you need it](#why-you-need-it)
- [What it is](#what-it-is)
- [Who it's for](#who-its-for)
- [Quick start](#quick-start)
- [The 9 skills in detail](#the-9-skills-in-detail)
- [Orchestrator: workflows by task size](#orchestrator-workflows-by-task-size)
- [Installation options](#installation-options)
- [Upgrade & uninstall](#upgrade--uninstall)
- [Before / after](#before--after)
- [FAQ](#faq)
- [Coexisting with your existing rules](#coexisting-with-your-existing-rules)
- [Contributing](#contributing)
- [Design principles](#design-principles)
- [Roadmap](#roadmap)
- [Acknowledgments](#acknowledgments)
- [Buy me a coffee](#buy-me-a-coffee)
- [License](#license)

## Quick start

```bash
# One command installs all 9 skills into Claude Code
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash
```

Restart your agent (or open a new session) and the skills activate automatically. No configuration, no API keys.

Then just describe your task — skills load on trigger. Say "add an export feature" and `clarify-first` will pin down the requirements first; say "fix this bug" and `debug-like-detective` runs its detective workflow.

## The 9 skills in detail

### using-agent-craft (orchestrator)

Read me first on any development task. Its only job: **assemble exactly the right workflow for the task size — no more, no less**, deciding which skills to use and in what order.

Without the orchestrator, all 8 skills could fire at once, and even a tiny change would go through clarification confirmations and planning — annoying. With it, S-size tasks are nearly invisible, L-size tasks get the full pipeline.

### clarify-first (requirement clarification)

The biggest failure mode of AI coding isn't bad code — it's coding before understanding.

- **One question at a time**, multiple-choice preferred, always with your recommendation and reasoning (you're hired to make decisions, not to relay messages)
- Usually converges in 3–5 questions; if question 6 still goes nowhere, the requirement itself isn't ready — stop
- Four-item convergence checklist before coding: inputs/outputs concrete with examples, edge cases defined, "done" verifiable, tech choices decided
- Restate the requirement in 5–10 lines and get a "yes" before starting
- Includes a **vague-word translation table**: when you hear "just make it simple" / "ASAP" / "like XX", you know what to ask

### plan-before-code (plan before coding)

Write down "how I'm going to do it" and show the user before writing code.

- Read the code first: find related implementations, follow conventions, confirm dependencies
- Fixed format, nothing optional: **goal** (one line) / **steps** (down to file and function names) / **risks** (at least 1 — if you can't think of any, you haven't thought it through) / **verification** (how you'll prove it works)
- **30-line rule**: over 30 lines → full plan; under → three sentences (what, how, how to verify)
- User approves before you code; if the plan breaks mid-way, stop, update the plan, re-confirm

### tdd-red-green (test-driven development)

Red → green → refactor. The order is non-negotiable.

- **Red**: write one failing test first, named `test_<scenario>_<expectation>`; confirm it's red *for the reason you expect*
- **Green**: write the minimal code to pass — dumb code and hardcoding allowed, YAGNI
- **Refactor**: only on green — dedupe, rename, extract functions, re-run tests after each step
- Bug fixes start with a reproduction test, which is never deleted (regression protection)
- No `sleep` in tests; if the same red light survives 3 cycles, stop — it's a design problem, not a test problem

### review-five-axes (five-axis code review)

A structured review framework. Cures both "looks good to me" (a non-review) and nitpicking (rude and useless).

- Five axes, one by one: **correctness** (can you construct a counterexample?) / **edge cases** (nulls, 0, huge inputs, concurrency, timeouts) / **readability** (will someone understand this in 6 months?) / **security** (injection trio, authz, secrets in logs) / **performance** (N+1 queries, memory)
- Every reported issue must answer "**what happens if we don't fix it**" — if you can't answer, don't report it
- Severity required: blocker / major / minor; more than 3 minors is padding
- Fixed format per issue: location, symptom, why it's a problem, how to fix
- Final verdict, pick one: approve / approve after minor fixes / request changes

### debug-like-detective (systematic debugging)

Debug like a detective. Cures "let me try changing this and see".

- **Reproduce**: write minimal repro steps; never fix a bug you haven't seen (adding logs/monitoring/repro scripts doesn't count as changing code — that's allowed)
- **Evidence**: full error output, relevant logs, `git log` (80% of bugs come from recent changes)
- **Hypotheses**: 1–3 most likely root causes, ranked; more than 3 means you need more evidence
- **Minimal experiments**: one per hypothesis, change exactly one variable per experiment; the goal is to *rule out*, not to prove
- **Binary search**: comment out half, mock a layer — a few rounds narrows it to one line
- After fixing, state the root cause in one sentence ("because X, therefore Y") — if you can't, you haven't found it
- 3 falsified hypotheses in a row → stop: write down the evidence chain, change perspective, consider escalating

### refactor-small-steps (small-step refactoring)

Refactor in small, verifiable, rollback-safe steps. Cures "this code is trash, let's rewrite it".

- **Three questions before touching anything**: will this code change in the next 3 months? Are tests protecting it? Is the timing right? (Never refactor core flows the night before launch)
- No tests, no refactoring: if no test calls the function you're changing, write tests first
- List changes sorted by risk: renames, constant extraction → function extraction, dedupe → class splits, interface changes
- Definition of "one step": full test suite passes, committable alone, describable in one sentence
- Each step states what changed and *why it's safe* ("all tests green" counts; "I think it's fine" doesn't)
- Red light → roll back the step; no features and no bug fixes mixed into a refactor

### write-chinese-docs (Chinese technical writing)

Conventions for writing technical docs for Chinese developers: plain language, no translationese, no AI slop.

- Fixed structure: **conclusion first** (one line: what it is, what problem it solves), then usage (shortest runnable example up front), details last
- One paragraph ≤ 4 lines, one idea per paragraph
- Plain-language checklist: delete "值得一提的是" / "不仅…更是…" / "首先、其次、最后" / buzzwords like "赋能、闭环、颗粒度"; space between Chinese and English terms; space between numbers and units ("10 GB")
- Code examples must run; the first one under 10 lines
- Comments explain *why*, not *what*; read it aloud when done — rewrite anything awkward

### retrospective (postmortems)

Fact → root cause → actionable items. Cures both the praise-report and the blame-report.

- **Facts**: what happened, no judgments; impact in numbers (downtime, affected users); "slow response" is banned, "P99 went from 200 ms to 8 s" is required
- **Root causes**: "five whys" down to the system/process level; "Xiao Wang was careless" is not a root cause, "no code review for config changes" is; no names in this section
- **Action items** need all four: concrete action, owner, deadline, acceptance criteria; **owners and deadlines must be asked from the user, never invented**; max 5 items
- One page: facts, causes, actions each take a third; action items are tracked and reviewed at the next retro

## Orchestrator: workflows by task size

| Size | Example | Workflow |
|---|---|---|
| S (small) | Copy changes, typo fixes, add logging (≤30 lines) | Just do it; mentally run the five axes after |
| M (medium) | New feature, bug fix, 2–3 files | Clarify → plan → TDD → review |
| L (large) | New module, core flows, multi-person | Full clarification → full plan (written user approval) → split into M sub-tasks with TDD → review each → retro |
| Bug fix | Errors, wrong behavior, failing tests | Debug → TDD (bug-fix flow) → review |
| Refactor | Pay down tech debt, split big functions | Small-step refactoring throughout |

Skills hand off to each other: clarification notes feed the plan, the plan's verification section becomes the first test's assertions, debugging notes feed the retro's facts.

## Installation options

### Find your agent first

| Your agent | Skills directory | Install command |
|---|---|---|
| Claude Code | `~/.claude/skills` | `--target claude` (default, can omit) |
| Codex / Cursor / Gemini CLI / Copilot / OpenCode / Cline / Warp / Zed / Pi… (40+) | `~/.agents/skills` | `--target codex` (or cursor / gemini / copilot…, same result) |
| Windsurf | `~/.windsurf/skills` | `--target windsurf` |
| Trae | `~/.trae/skills` | `--target trae` |
| Qoder | `~/.qoder/skills` | `--target qoder` |

Directory mappings follow [vercel-labs/skills](https://github.com/vercel-labs/skills) (79 agents covered). Most modern agents converged on `~/.agents/skills`, so one install covers them all.

### Other ways to install

```bash
# Via the community skills CLI (auto-detects your agent)
npx skills add TTNAN/agent-craft-cn

# Install a single skill
npx skills add TTNAN/agent-craft-cn --skill tdd-red-green
```

**Claude Code plugin marketplace**: in Claude Code, run `/plugin`, choose Add marketplace, enter `https://github.com/TTNAN/agent-craft-cn`, then install the plugin.

**Manual install**: copy folders from `skills/` into your agent's skills directory.

### Stable install (recommended for production)

The one-line script pulls `main` by default (latest, but may include unreleased changes). For stability, pin a tag:

```bash
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --ref v0.2.0
```

Formal releases are tagged (see [CHANGELOG](./CHANGELOG.md)) — don't rely on `main` alone.

### One-line install (recommended)

```bash
# Claude Code: all 9 (default target, can omit)
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash

# Codex / Cursor / Gemini CLI / Copilot / OpenCode / Cline / Warp / Zed…
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target codex

# Windsurf / Trae / Qoder
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target windsurf

# Old Codex versions: also install legacy ~/.codex/skills
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target codex --legacy

# Everything above
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target all
```

### Install one skill / pin a version / help

```bash
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --skill tdd-red-green
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --ref v0.2.0
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --help
```

### Manual install

```bash
git clone https://github.com/TTNAN/agent-craft-cn
cp -r agent-craft-cn/skills/* ~/.claude/skills/   # Claude Code
cp -r agent-craft-cn/skills/* ~/.agents/skills/   # Codex (current official dir; legacy: ~/.codex/skills)
```

### Claude Code plugin

`.claude-plugin/plugin.json` is ready for marketplace distribution:

```
/plugin marketplace add TTNAN/agent-craft-cn
/plugin install agent-craft-cn@agent-craft-cn
```

## Upgrade & uninstall

```bash
# Upgrade: just reinstall. Skills previously installed by this package are
# overwritten directly; your own same-named skills (e.g. your own
# retrospective) are moved to ~/.agent-craft-cn-backup/ — never lost,
# never loaded alongside the new version.
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash

# Uninstall: removes only this package's 9 skills (identified by install
# marker), never touches yours.
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --uninstall
```

## Before / after

**You say: "add an export feature"**

- Before: the AI dumps 200 lines of Excel-export code on you; you say "I wanted CSV" — rework.
- After: the AI asks one question at a time — "Export what data? The current table, or everything?" You say "everything"; "What format? Excel or CSV? I'd suggest CSV — Excel chokes on large data." You say "CSV"; it restates the requirement, you confirm, then it starts. Plan, tests, and review follow as one pipeline — CSV-escaping pitfalls get caught at review.

**You say: "there's a bug in production, fix it"**

- Before: the AI goes "let me try changing this and see" — three changes later the bug is still there and the code is messier.
- After: the AI reproduces, hypothesizes, designs minimal experiments, binary-searches to the root cause, then tells you "root cause is X; watch Y for this class of problems" — plus a regression test.

Real cases (including real failures from this project's own development) live in [docs/before-after.md](./docs/before-after.md).

> Real recordings / transcripts wanted (docs/before-after.md). Open an issue with your before/after.

## FAQ

**What's the relationship with superpowers?**

Inspired by it, but this pack is natively rewritten in Chinese — not a translation. Every rule follows real Chinese developer workflows, plus things superpowers doesn't have: an orchestrator skill (workflows by task size), AI-countable thresholds, and Chinese technical-writing conventions.

**Won't the AI become annoying, asking about everything?**

No. The orchestrator assembles workflows by task size: sub-30-line changes are nearly invisible; only L-size tasks get the full pipeline. Process is a cost, not a medal.

**What if a skill name collides with mine?**

The installer detects it: previously installed package skills are overwritten; your own same-named skills are moved to `~/.agent-craft-cn-backup/` — never lost, never loaded alongside the new version.

**Which agents are supported?**

Claude Code (`~/.claude/skills`); Codex, Cursor, Gemini CLI, Copilot, OpenCode, Cline, Warp, Zed and 40+ more (all read `~/.agents/skills` — one install covers them); Windsurf, Trae, Qoder. Mappings follow vercel-labs/skills (79 agents). They're plain SKILL.md files, so other Agent-Skills-compatible tools should work too.

**Is uninstall clean?**

`--uninstall` removes only this package's 9 skills (identified by install marker) — yours are untouched.

**Do Chinese skills work in English projects?**

Yes. Methodology is language-independent — with one exception: `write-chinese-docs` only governs Chinese docs.

**Will it upload my data?**

No. The 9 skills are 9 Markdown files, pure local text: no network calls, no packages, no data collection. They work offline after install — your code never passes through any third-party server. The install script does one thing: copy files from GitHub into your skills directory.

## Coexisting with your existing rules

Many repos already have CLAUDE.md, .cursor/rules, or their own skills. How does this pack fit in?

**Priority**: project-specific rules > this pack's skills > the model's default behavior. Project rules like "this project uses pnpm, not npm" always win; this pack covers general methodology (clarify before coding), which doesn't conflict with project rules. In a real conflict, the project wins.

**Make the orchestrator run first**: add one line to your CLAUDE.md (or .cursor/rules):

> When you get a development task, first read `~/.claude/skills/using-agent-craft/SKILL.md` and follow its workflow.

One line, and the orchestrator goes first.

**Full example**: your CLAUDE.md can look like this:

```markdown
## Development rules

- This project uses pnpm, not npm
- When you get a development task, first read `~/.claude/skills/using-agent-craft/SKILL.md` and follow its workflow
- TDD applies to business logic only; pure UI/style changes skip tests
- In code review, security issues (injection, broken access control) are veto-level
```

Project rules (pnpm, TDD scope) and methodology (orchestrator workflow) each mind their own business — no conflicts.

**You already have your own skills**: name collisions are automatically backed up to `~/.agent-craft-cn-backup/` on install; non-colliding ones run side by side without interference.

## Contributing

Issues and PRs are welcome. The most valuable contributions, in priority order:

1. **Real conversation logs**: failure moments / moments the skills kicked in while you used them — add to `docs/before-after.md` (format at the end of the file). **Logs from outside users are more valuable than the author's own** — just open an issue and paste the raw conversation, we'll format it
2. **Eval scores**: run `docs/eval-prompts.md` once and post a model's 4 scores in an issue
3. **Eval is required for skill changes**: after changing a skill, run `docs/eval-prompts.md` and paste the score delta in the PR description — PRs with regressed scores don't get merged
4. **Dead link reports**: a broken link in the README? Just file an issue
5. **New skill proposals**: first explain in an issue what problem it solves, what triggers it, and why the orchestrator can schedule it — write it after discussion
6. **Typos / AI slop**: PRs welcome, even one-liners

## Design principles

1. **Chinese-native**: written from scratch in Chinese, following real Chinese developer collaboration habits.
2. **Executable, not slogans**: no "focus on code quality" hand-waving — every rule is a checkable action.
3. **Countable thresholds**: no "no progress for 30 minutes" (an AI can't feel time) — instead "the same red light survived 3 cycles".
4. **Boundaries**: every skill states what it does *not* do, so the AI can't run wild with it.
5. **Zero dependencies**: plain SKILL.md text. No packages, no network, no data collection.

## Roadmap

The 9 skills already cover the backbone of the development cycle. Future additions, in priority order:

1. **Security deep-dive**: dedicated review for injection, broken access control, leaked secrets (security is currently just one axis of the five-axis review)
2. **Performance troubleshooting**: methodology for slow queries, memory leaks, P99 degradation
3. **Architecture Decision Records (ADR)**: how to write and review ADRs for technical choices
4. **Release checklist**: the last gate before going live

We won't add too many at once — the point is to keep the set schedulable by the orchestrator.

**Next up**: the highest-priority addition is a **security review skill** (injection, broken access control, leaked secrets) — security is currently just one axis of the five-axis review, which isn't enough for real projects. Want in? Open an issue titled `[roadmap] security review skill` — first discuss "what triggers it, how the orchestrator schedules it", then write it.

Vote in issues.

## Acknowledgments

Inspired by two projects in the English-speaking world:

- [obra/superpowers](https://github.com/obra/superpowers) — the pioneer of packing development methodology into agent skills
- [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — the layered thinking behind the five-axis review and orchestrator skills

This pack is natively rewritten in Chinese, not a translation.

## Buy me a coffee

If this project saved you some time, feel free to buy me a coffee. ☕

| Alipay | WeChat Pay |
| ------ | ---------- |
| ![Alipay QR code](assets/alipay.jpg) | ![WeChat Pay QR code](assets/wechat-pay.png) |

## License

MIT, see [LICENSE](./LICENSE).
