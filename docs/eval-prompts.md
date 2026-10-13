# Skill 评估提示集

方法论类 skill 很难自动化测试。这套提示集是轻量替代方案：4 个固定任务，每个任务看 AI 第一轮输出，按评分表打分。用来对比**不同模型**，或**同一模型在 skill 改版前后**的表现。

用法：每个任务独立开新会话，把提示词原样发给 AI，只看第一轮输出。

## 任务 1：澄清（测 clarify-first）

**提示词**：

```
帮我加个导出功能。
```

**评分**（满分 3）：

- 1 分：没有直接开工写代码，而是先提问
- 1 分：一次只问一个问题（而不是一次甩五个选择题）
- 1 分：问题是选择题，且给了推荐和理由

## 任务 2：计划（测 plan-before-code）

**提示词**：

```
给 todo-app 的任务列表加个导出 CSV 按钮，数据量可能上万条。
```

**评分**（满分 3）：

- 1 分：动手前先给了计划，而不是直接写代码
- 1 分：计划包含目标 / 步骤 / 风险点 / 验证方法四项
- 1 分：风险点提到了大数据量下的内存问题（或同类真风险），而不是"暂无风险"

## 任务 3：评审（测 review-five-axes）

**提示词**：

```
帮我 review 这段代码：

def register(username, password):
    query = "INSERT INTO users VALUES ('" + username + "', '" + password + "')"
    cursor.execute(query)
    db.commit()

def get_orders(user_id):
    orders = db.query("SELECT * FROM orders WHERE user_id=" + str(user_id))
    result = []
    for o in orders:
        u = db.query("SELECT name FROM users WHERE id=" + str(o.user_id))
        result.append((o, u))
    return result
```

**评分**（满分 3）：

- 1 分：报出了 SQL 注入（两处字符串拼接），且标为 blocker
- 1 分：报出了循环里查库（N+1）
- 1 分：没有凑数——minor 不超过 3 条，不评括号换行、变量名长短这类风格问题

## 任务 4：调试（测 debug-like-detective）

**提示词**：

```
导出 CSV 功能挂了，报 500 错误，帮我看看。
```

**评分**（满分 3）：

- 1 分：先问复现条件（筛选条件、数据量、怎么点的），而不是直接改代码
- 1 分：提出了假设（而不是"试试改这里看看"）
- 1 分：能说清验证思路（一句话：因为 X，所以 Y；或打算怎么验证）

## 记分表

| 模型 / 版本 | 任务 1 澄清 | 任务 2 计划 | 任务 3 评审 | 任务 4 调试 | 总分 /12 |
|---|---|---|---|---|---|
| （示例）Claude X | 3 | 2 | 3 | 3 | 11 |
| | | | | | |

建议：每次改 skill 后跑一遍，把分数变化贴到 PR 描述里——分数掉了的 PR 不合并。某个任务长期满分，说明这个 skill 已经稳定，可以把精力放到别的 skill 上。
