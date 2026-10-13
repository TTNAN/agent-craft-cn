# 真实 Before / After 记录

以下案例全部来自本项目（agent-craft-cn）自己的开发过程：用户拿 skill 的规则来评审 skill 本身，抓到的都是真问题。

---

## 案例 1：clarify-first 被自己的 README 打脸

**Skill**：clarify-first（需求澄清）

**Before**（没按 skill 来）：

README 初版的"装上前后对比"里写的是：

> AI 先问你"账号体系用手机号还是邮箱？密码怎么存？要不要限流？"——三个问题问完……

而 clarify-first 的铁律第一条就是"**一次只问一个问题**"。用户评审时直接指出：

> "README 自相矛盾。clarify-first 的铁律是'一次只问一个问题'，但 README 的对比示例里 AI 一口气问了三个问题。别人第一眼看到的就是这段。"

**翻车点**：写 skill 的人自己没按 skill 干活。最讽刺的是，被打脸的段落恰恰是用来展示 skill 效果的。

**After**（按 skill 来）：

示例改成一次只问一个：

> AI："导出什么数据？当前页面的表格，还是全部数据？"
> 用户："全部数据。"
> AI："格式呢？Excel 还是 CSV？我建议 CSV，数据量大的时候 Excel 容易炸。"

**Skill 生效点**：clarify-first 的"第二步：一次只问一个问题"反过来约束了文档作者。skill 的价值不只在 AI 执行，也在给人立检查标准。

---

## 案例 2：write-chinese-docs 扫出自己的 AI 味

**Skill**：write-chinese-docs（中文技术写作）

**Before**（没按 skill 来）：

write-chinese-docs 明令禁用"不是…而是…"句式（除非真有对比），但仓库里自己写着：

- README："……这套**不是翻译版**。"
- clarify-first："……这是红灯，**不是绿灯**"

**翻车点**：规则制定者双标。读者如果先读到 skill 再读到 README，会觉得"这规则你自己都不信"。

**After**（按 skill 来）：

全仓库 grep 扫一遍，改成：

- "这套**从头用中文写**。"
- "这是红灯，停下来问。"

规则本身保留（严格版），自己的稿子先过一遍检查清单。

**Skill 生效点**：write-chinese-docs 第四步"说人话检查清单"是一份可机械执行的 grep 列表。能 grep 的规则，就不依赖自觉。

---

## 案例 3：install.sh 的 `--help` 管道 bug

**Skill**：debug-like-detective（系统化调试）

**Before**（用户实测翻车）：

用户跑 `curl -fsSL …/install.sh | bash -s -- --help`，报错：

```
sed: can't read bash
```

**根因**（一句话）：`usage()` 用 `sed -n '2,/^set -euo/p' "$0"` 读脚本自身的注释当帮助文字；管道运行时 `$0` 是 `bash` 不是文件，sed 读不到。

这是典型的"在我机器上是好的"——作者本地 `bash install.sh --help` 永远正常，只有 `curl | bash` 的用户会炸。

**After**（按 skill 来）：

帮助文字改成 heredoc 直接写在函数里，不再依赖 `$0`：

```bash
usage() {
cat <<'HELP_EOF'
agent-craft-cn 安装 / 卸载脚本
...
HELP_EOF
}
```

用户复测 `cat install.sh | bash -s -- --help` 通过。

**Skill 生效点**：debug-like-detective 第一步"复现"——这个 bug 只有复现了（管道场景）才能看到；第六步"说清楚根因再写修复"——根因一句话讲清后，修法自己就出来了（去掉对 `$0` 的依赖）。

---

## 怎么贡献你的案例

格式建议：

```markdown
## 案例：xxx（日期）

**Skill**：
**任务**：一句话描述任务
**Before**：贴关键对话片段，标出翻车点
**After**：贴关键对话片段，标出 skill 生效点
```

欢迎提 issue 分享（有专门的[真实案例模板](https://github.com/TTNAN/agent-craft-cn/issues/new?template=before-after.md)，贴原始对话就行，格式我们来整理），好的案例会收录进 README。
