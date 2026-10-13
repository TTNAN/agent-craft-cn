# CHANGELOG

## v0.2.0（2026-10-13）

- docs：README 开头加厚（为什么需要它 / 它是什么 / 适合谁）+ 多 Agent 安装矩阵（13 个 target，目录映射参考 vercel-labs/skills）
- docs：`docs/before-after.md` 换成 3 个真实案例（本项目开发过程中真实发生的：clarify-first 自打脸、write-chinese-docs 扫出 AI 味、install.sh 管道 bug）
- docs：新增 `docs/eval-prompts.md` 评估提示集（4 个固定任务 + 评分表）
- docs：README 新增"和已有规则共存""路线图"两节
- skill：`using-agent-craft` 加主动声明（M/L 档没明确跳过时主动说走完整流程）+ 压缩规则（纯前端 / 一次性脚本 / 基础设施 / 英文项目）+ description 加触发词
- skill：`write-chinese-docs` 边界加"只管中文"

## v0.1.0（2026-10-12）

首个版本。9 个中文原生方法论 skill：

- `using-agent-craft`：总控，按任务大小（S/M/L）拼装流程
- `clarify-first`：需求澄清，一次只问一个问题
- `plan-before-code`：先计划后编码（30 行分界线）
- `tdd-red-green`：测试驱动，红→绿→重构
- `review-five-axes`：五维代码评审，只报真问题
- `debug-like-detective`：系统化调试，复现→假设→最小实验→二分定位
- `refactor-small-steps`：小步重构，测试护航
- `write-chinese-docs`：中文技术写作，去翻译腔去 AI 味
- `retrospective`：复盘，事实→归因→行动项

配套：一键安装/卸载脚本（Claude Code + Codex 新旧目录）、Claude Code 插件配置、MIT 协议。
