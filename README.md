# agent-craft-cn

中文原生的 Agent 软件开发方法论技能包：教你的 AI 编程助手像资深工程师一样干活。

英文圈有 superpowers 这样的先例，但那是英文语境。这套**从头用中文写、为中国开发者调**：需求怎么问、计划怎么写、测试先行、代码评审、调试、重构、中文技术写作、复盘，外加一个总控 skill 按任务大小拼流程——覆盖一次完整开发循环。

当前版本：**v0.1.0**（见 [CHANGELOG](./CHANGELOG.md)）

## 30 秒上手

```bash
# 一行命令，装全部 9 个 skill 到 Claude Code
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash

# 装到 Codex（~/.agents/skills，新版官方目录）
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target codex

# 老版本 Codex 才需要：额外装旧版 ~/.codex/skills 目录
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target codex --legacy

# 两个都装 / 只装某一个 / 指定版本 / 看帮助
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target all
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --skill tdd-red-green
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --ref v0.1.0
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --help
```

装完重启 Agent（或开新会话），skill 自动生效。不用配置，不用 API key。

已有同名 skill？安装时会自动备份成 `名字.bak-日期`，不会直接覆盖。

卸载（只删本包的 skill，不动你自己的）：

```bash
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --uninstall
```

## 9 个 skill

| Skill | 干什么 | 一句话 |
|---|---|---|
| `using-agent-craft` | 总控 | 接到开发任务先读我：按任务大小拼流程（S/M/L 三档），决定用哪几个 skill |
| `clarify-first` | 需求澄清 | 一次只问一个问题，挖到"可直接动手"的粒度才开工，严禁脑补需求 |
| `plan-before-code` | 先计划后编码 | 动手前把方案写成计划给你确认，小任务可压缩成三句话 |
| `tdd-red-green` | 测试驱动 | 先写失败的测试，再写最简实现，最后重构；严禁后补测试凑覆盖率 |
| `review-five-axes` | 五维代码评审 | 正确性 / 边界 / 可读性 / 安全 / 性能，只报真问题，不凑数 |
| `debug-like-detective` | 系统化调试 | 复现→假设→最小实验→二分定位，修完必须说清根因 |
| `refactor-small-steps` | 小步重构 | 每次只动一步，测试护航，严禁大爆炸重写 |
| `write-chinese-docs` | 中文技术写作 | 写 README/注释：去翻译腔、去 AI 味，短段落说人话，先给结论 |
| `retrospective` | 复盘 | 事实→归因→可执行的行动项（负责人 + 截止时间问用户，不许编） |

## 装上前后对比

**场景：你说"帮我加个导出功能"**

- 没装之前：AI 直接甩给你 200 行导出 Excel 的代码，你说"我要的是 CSV"，返工。
- 装上之后：AI 一次只问一个问题——"导出什么数据？当前页的表格，还是全部数据？"你答"全部"；"格式呢？Excel 还是 CSV？我建议 CSV，数据量大时 Excel 容易炸。"你答"CSV"；最后复述一遍需求你确认了才开工。计划、测试、评审一条龙，CSV 转义这种坑在评审时就被拦下来。

**场景：线上出了个 bug，你说"修一下"**

- 没装之前：AI "试试改这里看看"，改了三处，bug 还在，代码更乱了。
- 装上之后：AI 先复现，提假设，设计最小验证实验，二分定位到根因，修完告诉你"根因是 X，以后这类问题看 Y"，还附带一个回归测试。

> 真实使用录屏 / 对话记录待补充（docs/before-after.md）。欢迎提 issue 贴你的 before/after。

## 手动安装

```bash
git clone https://github.com/TTNAN/agent-craft-cn
cp -r agent-craft-cn/skills/* ~/.claude/skills/   # Claude Code
cp -r agent-craft-cn/skills/* ~/.agents/skills/   # Codex（新版官方目录；老版本用 ~/.codex/skills）
```

## 做成 Claude Code 插件

`.claude-plugin/plugin.json` 已配好，也支持 marketplace 分发：

```
/plugin marketplace add TTNAN/agent-craft-cn
/plugin install agent-craft-cn@agent-craft-cn
```

## 设计原则

1. **中文原生**：从头用中文写。每条规则都按中国开发者的真实协作习惯写。
2. **可执行，不是口号**："注重代码质量"这种空话不会出现，每条都是能检查的动作。
3. **阈值可数**：不用"30 分钟没进展"这种 AI 感知不到的词，用"同一个红灯连续 3 次没变绿"这种能数的。
4. **有边界**：每个 skill 都写明"不做什么"，防止 AI 借题发挥。
5. **零依赖**：纯 SKILL.md 文本，不装包、不联网、不收数据。

## 致谢

思路上受英文圈两个项目启发：

- [obra/superpowers](https://github.com/obra/superpowers) —— 把开发方法论装进 Agent skill 的开创者
- [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) —— 五维评审与总控 skill 的分层思路借鉴自它

本包为中文原生重写，不是翻译版。

## 协议

MIT，见 [LICENSE](./LICENSE)。

---

## In English

**agent-craft-cn** is a Chinese-native collection of agent skills that teaches your AI coding assistant to work like a senior engineer: requirement clarification, planning before coding, TDD, five-axis code review, systematic debugging, small-step refactoring, Chinese technical writing, postmortems — plus an orchestrator skill that assembles the right workflow per task size.

While the English-speaking world has superpowers, this pack is written from scratch in Chinese for Chinese developers — not a translation. Each skill is concrete and checkable: no slogans, countable thresholds, explicit boundaries.

One-line install for Claude Code / Codex:

```bash
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash
```

MIT licensed. Contributions welcome — issues and PRs in Chinese or English.
