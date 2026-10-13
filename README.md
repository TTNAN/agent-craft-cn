[English](README_en.md) | **简体中文**

# agent-craft-cn

![version](https://img.shields.io/badge/version-v0.2.0-blue) ![license](https://img.shields.io/badge/license-MIT-green) ![skills](https://img.shields.io/badge/skills-9-orange)

**中文原生的 Agent 软件开发方法论技能包：教你的 AI 编程助手像资深工程师一样干活。**

## 为什么需要它

AI 编程助手现在的问题，不是写不出代码，是**干活的方式不像个资深工程师**：

- 你说"加个导出功能"，它吭哧吭哧写了 200 行导出 Excel，你说"我要的是 CSV"——**没听懂就开工**，返工的时间是第一次的三倍
- 线上出了 bug，它"试试改这里看看"，改了三处，bug 还在，代码更乱了——**调 bug 靠运气**，修完说不清根因
- 让它 review 代码，它说"整体不错，几点小建议：变量名 `u` 可以改成 `user`"——**评审凑数**，真问题（SQL 注入、N+1）一个没看见
- 项目做完让它复盘，它写"在大家的共同努力下取得了圆满成功"——**复盘写成表扬稿**，下次继续踩同一个坑

这些不是模型能力问题，是**缺一套工作方法**。资深工程师带新人，第一件事就是立规矩：需求先问清楚、动手前先写计划、测试先行、评审只报真问题、调 bug 先复现。这个包就是把这些规矩写成 9 个 skill，装进你的 AI 里。

## 它是什么

9 个中文原生 skill，覆盖一次完整开发循环：

- **using-agent-craft**（总控）：接到任务先读我，按任务大小拼流程，S 档小任务几乎无感，L 档大任务全流程护航
- **clarify-first**：需求澄清，一次只问一个问题，挖到可动手粒度才开工
- **plan-before-code**：先计划后编码，目标/步骤/风险/验证四件套，用户点头再动手
- **tdd-red-green**：测试驱动，红→绿→重构，顺序是死的
- **review-five-axes**：五维代码评审，只报真问题，不凑数
- **debug-like-detective**：系统化调试，复现→假设→最小实验→二分定位
- **refactor-small-steps**：小步重构，每一步都能验证、都能回滚
- **write-chinese-docs**：中文技术写作，说人话，去翻译腔，去 AI 味
- **retrospective**：复盘，事实→归因→可执行的行动项

英文圈有 superpowers 这样的先例，但那是英文语境。这套**从头用中文写**，还补了几样 superpowers 没有的东西：总控 skill（按任务大小拼流程，不是一股脑全上）、AI 可数的阈值（不用"30 分钟没进展"这种 AI 感知不到的词）、中文技术写作规范。

## 适合谁

每天用 Claude Code、Cursor、Codex、Gemini CLI 写代码的中国开发者。装完不用学，提需求的方式不变，AI 会在合适的时机自动按规矩干活。

当前版本：**v0.2.0**（见 [CHANGELOG](./CHANGELOG.md)）

## 目录

- [为什么需要它](#为什么需要它)
- [它是什么](#它是什么)
- [适合谁](#适合谁)
- [30 秒上手](#30-秒上手)
- [9 个 skill 详解](#9-个-skill-详解)
- [总控：按任务大小拼流程](#总控按任务大小拼流程)
- [安装方式一览](#安装方式一览)
- [升级与卸载](#升级与卸载)
- [装上前后对比](#装上前后对比)
- [常见问题](#常见问题)
- [和已有规则共存](#和已有规则共存)
- [怎么贡献](#怎么贡献)
- [设计原则](#设计原则)
- [路线图](#路线图)
- [致谢](#致谢)
- [请我喝杯咖啡](#请我喝杯咖啡)
- [协议](#协议)

## 30 秒上手

```bash
# 一行命令，装全部 9 个 skill 到 Claude Code
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash
```

装完重启 Agent（或开新会话），skill 自动生效。不用配置，不用 API key。

然后直接提需求就行，skill 会按触发条件自动加载。比如你说"帮我加个导出功能"，`clarify-first` 会先把需求问清楚；你说"修一下这个 bug"，`debug-like-detective` 会按破案流程走。

## 9 个 skill 详解

### using-agent-craft（总控）

接到任何开发任务时先读我。作用就一个：**按任务大小拼出刚好的流程，不多不少**，决定用哪几个 skill、按什么顺序用。

没有总控，8 个 skill 会同时触发，一个小改动也要过澄清的复述确认、计划的三句话，用户会觉得烦。有了总控，S 档小任务几乎无感，L 档大任务全流程护航。

### clarify-first（需求澄清）

AI 写代码最大的毛病不是写不出来，是没听懂就开工。

- **一次只问一个问题**，选择题优先，给出你的推荐和理由（用户请你来是拿主意的，不是当传声筒的）
- 一般 3 到 5 个问题收敛；问到第 6 个还在发散，说明需求本身不成立，停下来
- 四条收敛清单全部打勾才开工：输入输出能举例、边界情况有说法、"做完"可验证、技术选型定了
- 开工前用 5 到 10 行复述需求，用户说"对"再动手
- 附**模糊词翻译表**：听到"简单搞一下""尽快""和 XX 差不多"，就知道该问什么

### plan-before-code（先计划后编码）

动手前把"打算怎么做"写下来，给用户看一眼。

- 先读代码再写计划：找到相关实现、看惯例、确认依赖
- 固定格式，一项不能少：**目标**（一句话）/ **步骤**（具体到文件和函数名）/ **风险点**（至少 1 个，想不出说明没想清楚）/ **验证方法**（怎么证明做对了）
- **30 行分界线**：预计超过 30 行写完整计划，不超过压缩成三句话（做什么、怎么改、怎么验）
- 用户点头再动手；做到一半发现计划有问题，停下来更新计划、重新确认

### tdd-red-green（测试驱动）

红 → 绿 → 重构，三步循环，顺序是死的。

- **红**：先写一个失败的测试，命名 `test_场景_期望`；确认它是红的，而且红的原因是你预期的那个
- **绿**：写最少的代码让它通过，允许笨代码、允许硬编码，YAGNI
- **重构**：测试全绿的前提下，去重、改名、抽函数，每改一步跑一次测试
- 修 bug 先写复现测试，这个测试不许删（回归保护）
- 测试里禁 `sleep`；同一个红灯连续 3 次没变绿，停下来想设计（不是测试的问题）

### review-five-axes（五维代码评审）

结构化评审框架，专治两种烂评审："看起来不错"（等于没评）和硬挑刺（败人品）。

- 五个维度逐项过：**正确性**（能举出反例吗）/ **边界条件**（空值、0、超大输入、并发、超时）/ **可读性**（半年后的人能看懂吗）/ **安全**（注入三件套、越权、密钥进日志）/ **性能**（循环查库、内存）
- 每个问题必须回答"**不改会怎样**"，答不上来就不报
- 严重级别：blocker（必须改）/ major（应该改）/ minor（建议改），minor 超 3 条算凑数
- 固定格式：位置、现象、为什么是问题、怎么改，四项缺一不可
- 总结论三选一：通过 / 小改后通过 / 打回重写

### debug-like-detective（系统化调试）

像侦探破案一样调 bug，专治"试试改这里看看"。

- **复现**：写出最小复现步骤；复现不了的 bug 不许动手修（加日志、加监控、写复现脚本不算改业务逻辑，可以先上）
- **证据**：报错全文、相关日志、`git log`（80% 的 bug 是最近改动引入的）
- **假设**：列 1 到 3 个最可能的根因，按可能性排序；超过 3 个说明证据不足
- **最小验证**：每个假设对应一个实验，一次只动一个变量，目的是排除不是证明
- **二分定位**：范围太大就对半注释、对半 mock，几次就缩到一行代码
- 修完必须一句话说清根因（"因为 X，所以 Y"），说不清楚等于没修完
- 连续 3 个假设都被证伪，停下来：整理证据链，换视角，考虑升级找人

### refactor-small-steps（小步重构）

重构要小步快跑，每一步都能验证、都能回滚。专治"这代码太烂了，重写吧"。

- **动手前先过三问**：未来三个月还要改吗？测试护得住吗？现在是合适的时机吗？（上线前夜忍着）
- 无测试不许重构：要动的函数没有测试在调用它，先补测试
- 按风险从小到大列清单：改名、抽常量 → 抽函数、合并重复 → 拆类、改接口
- "一步"的定义：改完能跑全量测试、能单独提交、能一句话说清楚
- 每步写两句：改了什么、为什么安全（"测试全绿"算理由，"我觉得没问题"不算）
- 红灯就回滚这一步；重构中不加功能、不修 bug（发现了记下来，重构完再说）

### write-chinese-docs（中文技术写作）

给中国开发者写技术文档的规范：说人话，去翻译腔，去 AI 味。

- 结构固定：**先给结论**（一句话说清是什么、解决什么问题），再讲怎么用（最短可运行示例放最前面），最后讲细节
- 一段不超过 4 行，一段只讲一件事
- 说人话检查清单：删"值得一提的是""不仅…更是…""首先、其次、最后""赋能、抓手、闭环、颗粒度"；中英混排加空格（"使用 Git 进行版本控制"）；数字和单位之间加空格（"10 GB"）
- 代码示例必须能跑，第一个示例控制在 10 行以内
- 注释解释"为什么"而不是"是什么"；写完大声读一遍，拗口就重写

### retrospective（复盘）

按"事实 → 归因 → 可执行的行动项"复盘，专治表扬稿和甩锅稿。

- **摆事实**：只写发生了什么，不许带评价；影响用数字（故障时长、受影响用户数）；"响应很慢"不行，"P99 从 200 ms 涨到 8 s"行
- **挖根因**："五个为什么"至少挖到系统/流程层；"因为小王粗心"不是根因，"缺少 code review 环节"才是；归因里不许出现人名
- **行动项**四个要素缺一不可：具体动作、负责人、截止时间、验收标准；**负责人和截止时间必须问用户，不许编**；不超过 5 条
- 一页纸：事实、归因、行动项各 1/3 篇幅；行动项进跟踪，下次复盘先检查上次的

## 总控：按任务大小拼流程

| 档位 | 任务例子 | 流程 |
|---|---|---|
| S（小） | 改文案、修拼写、加日志（≤30 行） | 直接干，写完心里过一遍五维 |
| M（中） | 新功能、修 bug、跨 2–3 个文件 | 澄清 → 计划 → TDD → 评审 |
| L（大） | 新模块、动核心链路、多人协作 | 完整澄清 → 完整计划（用户书面确认）→ 拆子任务 TDD → 逐个评审 → 复盘 |
| 修 bug | 报错、行为不对、测试挂了 | 调试 → TDD（修 bug 流程）→ 评审 |
| 重构 | 还技术债、拆大函数 | 小步重构全程 |

skill 之间会交接：澄清的留痕进计划开头，计划的验证方法就是第一个测试的断言，调试记下的坑直接进复盘的事实部分。

## 安装方式一览

### 先看你用的 Agent

| 你用的 Agent | skill 目录 | 安装命令 |
|---|---|---|
| Claude Code | `~/.claude/skills` | `--target claude`（默认，不用写） |
| Codex / Cursor / Gemini CLI / Copilot / OpenCode / Cline / Warp / Zed / Pi…（40+ 家） | `~/.agents/skills` | `--target codex`（或 cursor / gemini / copilot…，效果一样） |
| Windsurf | `~/.windsurf/skills` | `--target windsurf` |
| Trae | `~/.trae/skills` | `--target trae` |
| Qoder | `~/.qoder/skills` | `--target qoder` |

目录映射参考 [vercel-labs/skills](https://github.com/vercel-labs/skills)（覆盖 79 个 Agent）。绝大多数现代 Agent 都收敛到了 `~/.agents/skills`，所以装一份就行。

### 其他安装方式

```bash
# 用社区工具 skills CLI（自动识别你用的 Agent）
npx skills add TTNAN/agent-craft-cn

# 只装某一个 skill
npx skills add TTNAN/agent-craft-cn --skill tdd-red-green
```

**Claude Code 插件市场**：在 Claude Code 里运行 `/plugin`，选 Add marketplace，填 `https://github.com/TTNAN/agent-craft-cn`，然后安装插件即可。

**手动安装**：把 `skills/` 目录下的文件夹拷到你 Agent 的 skills 目录。

### 稳定安装（推荐生产环境）

一键脚本默认拉 `main` 分支（最新，但可能有未发布的改动）。要稳定版，锁定 tag：

```bash
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --ref v0.2.0
```

正式版都打 tag 发布（见 [CHANGELOG](./CHANGELOG.md)），不要只靠 main。

### 一键安装（推荐）

```bash
# Claude Code：装全部 9 个（默认 target，不用写）
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash

# Codex / Cursor / Gemini CLI / Copilot / OpenCode / Cline / Warp / Zed…
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target codex

# Windsurf / Trae / Qoder
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target windsurf

# 老版本 Codex：额外装旧版 ~/.codex/skills
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target codex --legacy

# 以上全装
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --target all
```

### 只装某一个 / 指定版本 / 看帮助

```bash
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --skill tdd-red-green
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --ref v0.2.0
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --help
```

### 手动安装

```bash
git clone https://github.com/TTNAN/agent-craft-cn
cp -r agent-craft-cn/skills/* ~/.claude/skills/   # Claude Code
cp -r agent-craft-cn/skills/* ~/.agents/skills/   # Codex（新版官方目录；老版本用 ~/.codex/skills）
```

### Claude Code 插件

`.claude-plugin/plugin.json` 已配好，支持 marketplace 分发：

```
/plugin marketplace add TTNAN/agent-craft-cn
/plugin install agent-craft-cn@agent-craft-cn
```

## 升级与卸载

```bash
# 升级：直接重装就行。本包之前装的 skill 会直接覆盖，不备份；
# 如果你自己写过同名 skill（比如你手写的 retrospective），会被挪到
# ~/.agent-craft-cn-backup/，不会丢，也不会跟新版同时被加载。
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash

# 卸载：只删本包的 9 个 skill（认安装标记），不动你自己的
curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --uninstall
```

## 装上前后对比

**场景：你说"帮我加个导出功能"**

- 没装之前：AI 直接甩给你 200 行导出 Excel 的代码，你说"我要的是 CSV"，返工。
- 装上之后：AI 一次只问一个问题——"导出什么数据？当前页的表格，还是全部数据？"你答"全部"；"格式呢？Excel 还是 CSV？我建议 CSV，数据量大时 Excel 容易炸。"你答"CSV"；最后复述一遍需求你确认了才开工。计划、测试、评审一条龙，CSV 转义这种坑在评审时就被拦下来。

**场景：线上出了个 bug，你说"修一下"**

- 没装之前：AI "试试改这里看看"，改了三处，bug 还在，代码更乱了。
- 装上之后：AI 先复现，提假设，设计最小验证实验，二分定位到根因，修完告诉你"根因是 X，以后这类问题看 Y"，还附带一个回归测试。

真实案例（含本项目开发过程中真实发生的翻车记录）见 [docs/before-after.md](./docs/before-after.md)。

> 真实使用录屏 / 对话记录待补充（docs/before-after.md）。欢迎提 issue 贴你的 before/after。

## 常见问题

**和 superpowers 是什么关系？**

思路上致敬它，但这套是中文原生重写，不是翻译版。每条规则都按中国开发者的真实协作习惯写，还补了 superpowers 没有的东西：总控 skill（按任务大小拼流程）、AI 可数的阈值、中文技术写作规范。

**装上之后 AI 会不会变烦、什么都问？**

不会。总控（using-agent-craft）会按任务大小拼流程：30 行以内的小改动几乎无感，只有 L 档大任务才走全流程。流程是成本，不是勋章。

**跟我自己的 skill 重名了怎么办？**

安装时自动识别：本包之前装的直接覆盖；你自己的同名 skill 会被挪到 `~/.agent-craft-cn-backup/`，不会丢，也不会跟新版同时被 AI 加载。

**支持哪些 Agent？**

Claude Code（`~/.claude/skills`）、Codex / Cursor / Gemini CLI / Copilot / OpenCode / Cline / Warp / Zed 等 40+ 家（都读 `~/.agents/skills`，装一份就行）、Windsurf、Trae、Qoder。目录映射参考 vercel-labs/skills（覆盖 79 个 Agent）。纯 SKILL.md 文本，其他兼容 Agent Skills 的工具理论上也能用。

**卸载干净吗？**

`--uninstall` 只删本包的 9 个 skill（认安装标记），不动你自己的 skill。

**中文 skill 在英文项目里能用吗？**

能。方法论跟语言无关，只有一个例外：`write-chinese-docs` 只管中文文档。

**会上传我的数据吗？**

不会。9 个 skill 就是 9 个 Markdown 文件，纯本地文本：不联网、不装包、不收数据。装完断网也能用，你的代码不会经过任何第三方服务器。安装脚本只做一件事：从 GitHub 把文件拷到你的 skills 目录。

## 和已有规则共存

很多仓库已经有 CLAUDE.md、.cursor/rules 或自己的 skill，怎么跟本包共存？

**优先级**：项目专属规则 > 本包 skill > 模型默认行为。CLAUDE.md 里写的"本项目用 pnpm 不用 npm"这种具体规定，永远优先；本包管的是通用方法论（先澄清再动手），跟项目规定不打架。真冲突了，听项目的。

**让总控先跑**：在你的 CLAUDE.md（或 .cursor/rules）里加一行：

> 接到开发任务时，先读 `~/.claude/skills/using-agent-craft/SKILL.md`，按它的流程调度。

一句话，总控就排到最前面了。

**完整示例**：你的 CLAUDE.md 可以这么写：

```markdown
## 开发规范

- 本项目优先使用 pnpm，不用 npm
- 接到开发任务时，先读 `~/.claude/skills/using-agent-craft/SKILL.md`，按它的流程调度
- TDD 只对业务逻辑生效，纯 UI 样式改动跳过测试
- 代码评审时，安全问题（注入、越权）一票否决
```

项目规则（pnpm、TDD 范围）和方法论（总控流程）各管一摊，不打架。

**已有自己的 skill**：重名的安装时自动备份到 `~/.agent-craft-cn-backup/`；不重名的各跑各的，互不干扰。

## 怎么贡献

欢迎 Issue 和 PR。最有价值的贡献（按优先级）：

1. **真实对话记录**：用 skill 时的翻车片段 / 生效片段，贴到 `docs/before-after.md`（格式见文件末尾）。**外部用户的记录比作者自己的更有价值**，直接开 issue 贴对话就行，格式我们来整理
2. **评估打分**：按 `docs/eval-prompts.md` 跑一遍，把某模型的 4 项得分贴到 issue
3. **改 skill 必须跑评估**：改完 skill 后按 `docs/eval-prompts.md` 跑一遍，把分数变化贴到 PR 描述里——分数掉了的 PR 不合并
4. **失效链接报告**：README 里哪个链接挂了，直接提 issue
5. **新 skill 提案**：先在 issue 里讲清楚"解决什么问题、触发条件是什么、为什么总控能调度它"，讨论通过再写
6. **错别字 / AI 味**：直接 PR，改一行也欢迎

## 设计原则

1. **中文原生**：从头用中文写。每条规则都按中国开发者的真实协作习惯写。
2. **可执行，不是口号**："注重代码质量"这种空话不会出现，每条都是能检查的动作。
3. **阈值可数**：不用"30 分钟没进展"这种 AI 感知不到的词，用"同一个红灯连续 3 次没变绿"这种能数的。
4. **有边界**：每个 skill 都写明"不做什么"，防止 AI 借题发挥。
5. **零依赖**：纯 SKILL.md 文本，不装包、不联网、不收数据。

## 路线图

9 个 skill 已经覆盖了开发循环的主干。后续按需扩展，候选方向（按优先级）：

1. **安全深挖**：注入、越权、密钥泄漏专项评审（现在五维评审里安全只是一维）
2. **性能排查**：慢查询、内存泄漏、P99 劣化的方法论
3. **架构决策记录（ADR）**：技术选型怎么写 ADR，怎么评审 ADR
4. **发布检查清单**：上线前的最后一道门

一次不加太多，保持"总控能调度"的完整性。

**下一步**：优先级最高的是 **安全评审 skill**（注入、越权、密钥泄漏专项）——现在五维评审里安全只是一维，撑不起真实项目的需求。想参与的话直接开 issue，标题格式 `[roadmap] 安全评审 skill`，先讨论"触发条件是什么、总控怎么调度它"，通过再写。

欢迎在 issue 里投票。

## 致谢

思路上受英文圈两个项目启发：

- [obra/superpowers](https://github.com/obra/superpowers) —— 把开发方法论装进 Agent skill 的开创者
- [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) —— 五维评审与总控 skill 的分层思路借鉴自它

本包为中文原生重写，不是翻译版。

## 请我喝杯咖啡

如果这个项目帮你省了点时间，欢迎请我喝杯咖啡。☕

| 支付宝 | 微信支付 |
| ------ | -------- |
| ![支付宝收款码](assets/alipay.jpg) | ![微信支付收款码](assets/wechat-pay.png) |

## 协议

MIT，见 [LICENSE](./LICENSE)。
